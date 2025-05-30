# The Meta Ad Library API can omit ads in follow-up queries, so our daily collector sometimes
# 'misses' ads that later become inactive. Those ads then remain marked “active” in PoliDashboard
# because they fall outside the collector’s 2-day window.
#
# recollect_inactive.py fixes this by:
# 1. Finding ads with no stop date (ad_delivery_stop_time_raw) and last collected over 2 days ago (as per our DB).
# 2. Grouping them by page ID and their original date range.
# 3. Re-querying each page ID for the missing ads using a custom traversal.
#
# Because this is slow, run it for each country via cron (e.g. every two weeks).

import os
import re
import sys
import json
import datetime

from time import sleep
from datetime import date, datetime, timedelta
from fb_ads_library_cleanup import FbAdsLibraryTraversal
from push_to_dbs import SQLInserter

# If working in a team of multiple developers, a separate API token is ideal to not disrupt live collection
# Although on smaller datasets use of the same token is fine.
api_key = os.environ.get("FACEBOOK_API_KEY_CLEANUP")

if not api_key:
    print("API key not set. Please set the FACEBOOK_API_KEY_CLEANUP environment variable.")
    sys.exit(1)

    
# Pull the list of country codes directly from the countries.json file in the webapp
file_path = os.path.abspath(os.path.join('..', 'webapp', 'countries.json'))

# Load JSON data
with open(file_path, 'r', encoding='utf-8') as f:
    countries = json.load(f)

# Extract 'code' values as a list
country_codes = [country['code'] for country in countries]


all_ids_from_country = []
page_limit = 120

def process_pages(page_ids, newest_ad_time, oldest_ad_time, ads_looked_at):
    if page_ids == []:
        return

    page_ids = ",".join([str(x) for x in page_ids])

    collector = FbAdsLibraryTraversal(
        api_key,
        "id,ad_creation_time,ad_creative_bodies,ad_creative_link_captions,ad_creative_link_descriptions,ad_creative_link_titles,ad_delivery_start_time,ad_delivery_stop_time,ad_snapshot_url,currency,delivery_by_region,demographic_distribution,bylines,impressions,languages,page_id,page_name,publisher_platforms,spend,target_locations,target_gender,target_ages,estimated_audience_size",
        ".",
        country,
        after_date=oldest_ad_time,
        page_limit=page_limit,
        api_version="v21.0", # Current version as of Oct 2024
        search_page_ids=page_ids,
        max_date=newest_ad_time
    )

    for ads in collector.generate_ad_archives():
        for ad in ads:
            # Only update ads if we need to to avoid slow down
            if ad['id'] in ads_looked_at:
                sql_inserter.insert_ad(ad)
            else:
                if ad['id'] in all_ids_from_country:
                    sql_inserter.insert_ad(ad)


if __name__=="__main__":

    try:
        input_country = sys.argv[1]
        country_codes = [input_country]
    except IndexError:
        print('No country given, collecting from all countries')


    # The pipeline criteria for the ads are:
    # 1. The ad must have a funding entity (ads without funding entities are not compatible with PoliDashboard, so skip them)
    # 2. The last time we collected the ad (latest_collected) must be less than 3 days ago, this ensure we fetch ads that are outside of the collection window of the main collector
    # 3. The ad_delivery_stop_time_raw is NULL, this indicates that when we last collected it, the ad was definitely ACTIVE as only ACTIVE ads can have this field be NULL 
    
    for country in country_codes:
        print(f"Begin cleanup process for country: {country}")
        
        sql_inserter = SQLInserter(country)

        # First ensure there are actually ads that need checking
        sql_inserter.cursor.execute(
            f"""
            SELECT COUNT(*)
            FROM ad_data_{country.lower()}
            WHERE bylines_name IS NOT NULL 
                AND ad_delivery_stop_time_raw IS NULL
                AND latest_collected < %s
            """,
            (
                datetime.now() - timedelta(days=3),
            )
        )
        result = sql_inserter.cursor.fetchone()
        inactive_count = result[0]

        if inactive_count == 0:
            print(f"Country '{country}': No ads matching the cleanup criteria.")
            continue

        print(f"Number of documents matching criteria for cleanup: {inactive_count}")

        # Grab the list of all ids for tracking purposes
        sql_inserter.cursor.execute(
            f"""
            SELECT id
            FROM ad_data_{country.lower()}
            WHERE bylines_name IS NOT NULL 
                AND ad_delivery_stop_time_raw IS NULL
                AND latest_collected < %s
            ORDER BY ad_delivery_start_time DESC
            """,
            (
                datetime.now() - timedelta(days=3),     # Less than 3 days ago
            )
        )

        # Used for checking if there are returned in a request that we need but didn't track in our batch
        all_ids_from_country = [str(row[0]) for row in sql_inserter.cursor.fetchall()]

        sql_inserter.cursor.execute(
            f"""
            SELECT page_id, ad_delivery_start_time, id
            FROM ad_data_{country.lower()}
            WHERE bylines_name IS NOT NULL 
                AND ad_delivery_stop_time_raw IS NULL
                AND latest_collected < %s
            ORDER BY ad_delivery_start_time DESC
            """,
            (
                datetime.now() - timedelta(days=3),     # Less than 3 days ago
            )
        )

        rows = sql_inserter.cursor.fetchall()

        # A max of 10 ids can be processed per request:
        previous_page_id = None
        page_ids = []
        ad_ids_looked_at = []

        newest_ad_time = None
        oldest_ad_time = None

        for row in rows:
            page_id = row[0]
            ad_delivery_start_time = row[1]
            ad_id = row[2]

            if page_id is None or page_id is not previous_page_id:
                page_ids.append(page_id)
                previous_page_id = page_id

            # Figure out which ad is newest and which is oldest so we can set an optimal time range to request
            if newest_ad_time is None or ad_delivery_start_time > newest_ad_time:
                newest_ad_time = ad_delivery_start_time

            if oldest_ad_time is None or ad_delivery_start_time < oldest_ad_time:
                oldest_ad_time = ad_delivery_start_time

            ad_ids_looked_at.append(str(ad_id))
            
            if len(page_ids) >= 10:
                process_pages(
                    page_ids,
                    newest_ad_time.strftime('%Y-%m-%d'),
                    oldest_ad_time.strftime('%Y-%m-%d'),
                    ad_ids_looked_at
                )

                # Reset vars
                page_ids = []
                ad_ids_looked_at = []
                previous_page_id = None
                newest_ad_time = None
                oldest_ad_time = None

                continue

        # Process any leftover page ids...
        if page_ids:
            process_pages(
                page_ids,
                newest_ad_time.strftime('%Y-%m-%d'),
                oldest_ad_time.strftime('%Y-%m-%d'),
                ad_ids_looked_at
            )
        
        all_ids_from_country = []

    print("Done!")