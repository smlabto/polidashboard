'''
Description:
    This script will look inside of the facebook_regions_*county* collection and organize the location data
    into a dictionary "delivery_by_region". This dictionary is then added into the facebook_ads_*country* collection.
    This was done to make the jsontopo map implementation easier/faster. The fromat we are inserting this data is actually how
    we also receive it from the Facebook API, as a dictionary. Just it wasn't recorded before as part of the main ad document.
    ---------------------------------------------------------------------------------------------------------------------------
    This script will update the legacy entries in the database to have this dictionary. All future entries will be contain
    this dictionary automatically, as the collect.py script has now been updated to insert this dictionay.
'''

import sys
from datetime import datetime
from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError

if __name__=="__main__":
    try:
        country = sys.argv[1]
    except IndexError:
        print('No country given')
        exit()

    print('Running ', country, datetime.now())

    client = MongoClient()
    db = client["polidashboard"]
    region_collection = db["facebook_regions_" + country]
    ad_collection = db["facebook_ads_" + country]
    from pymongo import MongoClient

    # Query all documents from the source collection
    documents = region_collection.find()

    aggregated_data = {}
    for doc in documents:
        try:
            ad = doc["_id"]["ad"]
            region = doc["_id"]["region"]
            percentage = doc["percentage"]

            if ad not in aggregated_data:
                aggregated_data[ad] = {}

            aggregated_data[ad][region] = percentage
        except:
            pass

    # Insert aggregated data into the ad_collection specifically
    for ad, region_data in aggregated_data.items():
        try:
            ad_collection.update_one(
                {"_id": ad},
                {"$set": {"delivery_by_region": region_data}},
            )
        except DuplicateKeyError:
            pass

    # Close the MongoDB connection
    client.close()
