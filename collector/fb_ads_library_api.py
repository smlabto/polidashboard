#!/usr/bin/env python3

# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

import json
import re
from datetime import datetime

import requests
import pymongo
from time import sleep
db = pymongo.MongoClient()['polidashboard']

def get_ad_archive_id(data):
    """
    Extract ad_archive_id from ad_snapshot_url
    """
    return re.search(r"/\?id=([0-9]+)", data["ad_snapshot_url"]).group(1)


class FbAdsLibraryTraversal:
    default_url_pattern = (
        "https://graph.facebook.com/{}/ads_archive?unmask_removed_content=true&ad_type=POLITICAL_AND_ISSUE_ADS&access_token={}&"
        + "fields={}&search_terms={}&ad_reached_countries={}&search_page_ids={}&"
        + "ad_active_status={}&limit={}&"
        + "ad_delivery_date_min={}"
    )
    default_api_version = "v14.0"

    def __init__(
        self,
        access_token,
        fields,
        search_term,
        country,
        search_page_ids="",
        ad_active_status="ALL",
        after_date="1970-01-01",
        cutoff_after_date="2023-10-10",
        page_limit=100,
        api_version=None,
        retry_limit=3,
    ):
        self.page_count = 0
        self.access_token = access_token
        self.fields = fields
        self.search_term = search_term
        self.country = country
        self.after_date = after_date
        self.cutoff_after_date = cutoff_after_date
        self.search_page_ids = search_page_ids
        self.ad_active_status = ad_active_status
        self.page_limit = page_limit
        self.retry_limit = retry_limit
        if api_version is None:
            self.api_version = self.default_api_version
        else:
            self.api_version = api_version
        print ("set to api v=",api_version)

    def generate_ad_archives(self):
        next_page_url = self.default_url_pattern.format(
            self.api_version,
            self.access_token,
            self.fields,
            self.search_term,
            self.country,
            self.search_page_ids,
            self.ad_active_status,
            self.page_limit,
            self.after_date
        )
        return self.__class__._get_ad_archives_from_url(
            next_page_url, cutoff_after_date = self.cutoff_after_date, country=self.country, retry_limit=self.retry_limit
        )

    @staticmethod
    def _get_ad_archives_from_url(
        next_page_url, cutoff_after_date="2023-10-10", country="unknown", retry_limit=5
    ):
        last_error_url = None
        last_retry_count = 0
        start_time_cutoff_after = datetime.strptime(cutoff_after_date, "%Y-%m-%d").timestamp()
        time_to_regain_access = 0
        print("inside _get_ad_archives_from_ur ")
        while next_page_url is not None:
            if time_to_regain_access > 0:
                print(f"sleeping inside of ad archive for: {time_to_regain_access} minutes")
                sleep(time_to_regain_access * 60)
            else:
                if country == "us":
                    print(f"sleeping inside of ad archive for just 120 seconds to catch some air!")
                    sleep(120)
                else:
                    print(f"sleeping inside of ad archive for just 60 seconds to catch some air!")
                    sleep(60)

            try:
                response = requests.get(next_page_url)
                response_data = json.loads(response.text)
            except Exception as response_error:
                print("There was a error with the response, sleep 1 minute and try again")
                print(response_error)
                sleep(60)
                continue

            print(f"TIME: {datetime.now()}")
            print(f"RESPONSE HEADERS: {response.headers}")
            # print(f"RESPONSE USAGE: {response.headers['x-business-use-case-usage']}")

            business_use_case_usage = response.headers.get('x-business-use-case-usage', '{}')
            estimated_time = 0
            try:
                usage_data = json.loads(business_use_case_usage)
                # Extract 'estimated_time_to_regain_access' (assuming you are targeting the first key and the first dictionary item)
                key = next(iter(usage_data))  # Get the first key (e.g., '1651268252335870')
                estimated_time = usage_data[key][0].get('estimated_time_to_regain_access', 30)
            except (json.JSONDecodeError, KeyError, IndexError):
                estimated_time = 0
            except StopIteration:
                print("Ecountered Stop iteration error")
                estimated_time = 0
                
            print("Estimated time: " + str(estimated_time))
            estimated_time = int(estimated_time)
            if estimated_time > 0:
                sleep(int(estimated_time) * 60)

            db_name = "api_log_primary_key"
            if country == "us":
                db_name = "api_log_secondary_key"
            try:
                usage_data = json.loads(business_use_case_usage)
                # Extract 'estimated_time_to_regain_access' (assuming you are targeting the first key and the first dictionary item)
                key = next(iter(usage_data))
                response_headers = usage_data[key][0]

                db[db_name].insert_one({
                    "country": country,
                    "time_requested": datetime.now(),
                    "call_count": response_headers.get('call_count', 'N/A'),
                    "total_cputime": response_headers.get('total_cputime', 'N/A'),
                    "total_time": response_headers.get('total_time', 'N/A'),
                    "estimated_time_to_regain_access": response_headers.get('estimated_time_to_regain_access', 'N/A'),
                    "next_page_url": next_page_url
                })
                time_to_regain_access = response_headers['estimated_time_to_regain_access']
                if int(time_to_regain_access) == 0:
                    if int(response_headers['total_time']) > 100:
                        time_to_regain_access = 60 # make it 60 minutes

                if int(time_to_regain_access) > 0:
                    continue # Go straight to sleeping since we have hit regain access limit

            except Exception as ex:
                # reponse_headers
                db[db_name].insert_one({
                    "country": country,
                    "time_requested": datetime.now(),
                    "next_page_url": next_page_url,
                    "failed_api_call": True,
                    "error_msg": str(ex)
                })
                            
            if "error" in response_data:
                if next_page_url == last_error_url:
                    # failed again
                    if last_retry_count >= retry_limit:
                        print("Failed retry limit...")
                        raise Exception(
                            "Error message: [{}], failed on URL: [{}], Estimated time to regain access: [{}]".format(
                                json.dumps(response_data["error"]), next_page_url, estimated_time
                            )
                        )
                else:
                    last_error_url = next_page_url
                    last_retry_count = 0
                last_retry_count += 1
                continue

            filtered = list(
                filter(
                    lambda ad_archive: ("ad_delivery_start_time" in ad_archive)
                    and (
                        datetime.strptime(
                            ad_archive["ad_delivery_start_time"], "%Y-%m-%d"
                        ).timestamp()
                        >= start_time_cutoff_after
                    ),
                    response_data["data"],
                )
            )
            # print("after filtered....")
            if len(filtered) == 0:
                print(" if no data after the after_date, break")
                next_page_url = None
                break
            yield filtered

            if "paging" in response_data:
                next_page_url = response_data["paging"]["next"]
            else:
                next_page_url = None

    @classmethod
    def generate_ad_archives_from_url(cls, failure_url, after_date="1970-01-01"):
        """
        if we failed from error, later we can just continue from the last failure url
        """
        return cls._get_ad_archives_from_url(failure_url, after_date=after_date)
