#!/usr/bin/env python3

# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of the original source tree.
# Found here: https://github.com/facebookresearch/Ad-Library-API-Script-Repository/tree/main
#
# Modified by the Social Media Lab to serve the Polidashboard application.
# This file is to be used with recollect_inactive.py

import json
import re
import sys
from datetime import datetime
from time import sleep
import requests

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
        + "ad_delivery_date_min={}&"
        + "ad_delivery_date_max={}" # Adding max date to be able to query ad range more accurately to reduce API calls
    )
    default_api_version = "v21.0"

    def __init__(
        self,
        access_token,
        fields,
        search_term,
        country,
        search_page_ids="",
        ad_active_status="INACTIVE", # In this case we only care to look at inactive ads, if the ad is active then the main collect.py should pick it up
        after_date="1970-01-01",
        max_date=datetime.now().strftime('%Y-%m-%d'),
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
        self.max_date = max_date
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
            self.after_date,
            self.max_date
        )
        return self.__class__._get_ad_archives_from_url(
            next_page_url, cutoff_after_date = self.cutoff_after_date, country=self.country, retry_limit=self.retry_limit
        )

    @staticmethod
    def _get_ad_archives_from_url(
        next_page_url, cutoff_after_date="2023-10-10", country="unknown", retry_limit=3
    ):
        last_error_url = None
        last_retry_count = 0
        start_time_cutoff_after = datetime.strptime(cutoff_after_date, "%Y-%m-%d").timestamp()
        time_to_regain_access = 0

        while next_page_url is not None:
            # This is the amount of time it takes for API to stay at a stable rate
            print(f"sleeping inside of ad archive for: 130 seconds")
            sleep(130)

            response = requests.get(next_page_url)
            response_data = json.loads(response.text)

            try:
                response_headers = list(json.loads(response.headers['x-business-use-case-usage']).values())[0][0]
            except:
                pass
                
            try:
                response_headers = list(json.loads(response.headers['x-business-use-case-usage']).values())[0][0]
                time_to_regain_access = response_headers['estimated_time_to_regain_access']
            except Exception as ex:
                print(ex)
                response_headers = {}
                
            if "error" in response_data:
                estimated_time = '1'
                try:
                    estimated_time =  response_headers.get('estimated_time_to_regain_access', '30')
                except (json.JSONDecodeError, KeyError, IndexError):
                    estimated_time = '30'
                if next_page_url == last_error_url:
                    # failed again
                    if last_retry_count >= retry_limit:
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

            # Removed any filtering because we have already modified the request URL to get exactly what we need
            filtered = list(
                filter(
                    lambda ad_archive: ("ad_delivery_start_time" in ad_archive),
                    response_data["data"],
                )
            )
            
            if len(filtered) == 0:
                print(" if no data after the after_date, break")
                next_page_url = None
                break
            yield filtered

            if "paging" in response_data:
                next_page_url = response_data["paging"]["next"]
            else:
                next_page_url = None
            
            # Added to kill script to prevent API call runaway, where the limit has already been reached, and the script still attempts to call the API
            # Which contributes to increasing the API limit even more, without this the script would need to be killed manually. 
            try:
                if int(response_headers['total_time']) >= 100:
                    sys.exit()
            except:
                pass

    @classmethod
    def generate_ad_archives_from_url(cls, failure_url, after_date="1970-01-01"):
        """
        if we failed from error, later we can just continue from the last failure url
        """
        return cls._get_ad_archives_from_url(failure_url, after_date=after_date)
