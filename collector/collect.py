# The primary collection script to collect ads from the Facebook Ads Library.
# This script collects ads from the past 2 days and inserts them into a SQL database.

# This script should be run via cron job or other scheduling tool daily for each country collected
# If you want data for a period longer than 2 days.

# More explanation of the script can be found in the README.md file.

import os
import sys
import json
import requests

from time import sleep
from datetime import date, datetime, timedelta

from fb_ads_library_api import FbAdsLibraryTraversal
from push_to_dbs import SQLInserter

script_dir = os.path.dirname(os.path.abspath(__file__))
api_key = os.environ.get("FACEBOOK_API_KEY")

if not api_key:
    print("API key not set. Please set the FACEBOOK_API_KEY environment variable.")
    sys.exit(1)

if __name__=="__main__":
    try:
        country = sys.argv[1]
    except IndexError:
        print('No country given')
        exit()
    
    print('Beginning ad collection for country: ', country, "\nAt: ", datetime.now())

    page_limit = 100
    
    # Only fetch ads from the last 2 days
    after_date = datetime.now() - timedelta(days=2) 
    after_date = after_date.strftime('%Y-%m-%d')
        
    n = 0            
    try:
        collector = FbAdsLibraryTraversal(
            api_key,
            "id,ad_creation_time,ad_creative_bodies,ad_creative_link_captions,ad_creative_link_descriptions,ad_creative_link_titles,ad_delivery_start_time,ad_delivery_stop_time,ad_snapshot_url,currency,delivery_by_region,demographic_distribution,bylines,impressions,languages,page_id,page_name,publisher_platforms,spend,target_locations,target_gender,target_ages,estimated_audience_size",
            ".",
            country,
            after_date=after_date,
            page_limit=page_limit,
            api_version="v21.0", # Current version as of Oct 2024
        )

        sql_inserter = SQLInserter(country)
        
        n = 0
        for ads in collector.generate_ad_archives():
            for ad in ads:
                print("----- Start of inserting new ad -----")
                sql_inserter.insert_ad(ad)

                n += 1

    except Exception as e:
        print("Encountered Error!")
        print(e)

    print(f'Got {n} ads | on {str(datetime.now())}')
    print('Finished ad collection for country: ', country, "\nAt: ", datetime.now())