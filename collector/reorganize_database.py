'''
Description:
    reorganize_audience:
        This function will look inside of the facebook_audiences_*county* collection and create a new document for each ad
    where _id is the ad id. How this collections was initially setup was each document consisted of a percent and an object,
    The purpose of the object is to keep track of an age range, for that ad, however, there is a unique document for each age 
    range. This caused a lot of slowdown, because you can have 6 documents, that contain the same _id.ad value, but just different
    percent and age range. We still need the data formatted in this way because of how the frontend reads it, so to spead things up,
    we are creating a new document, with _id as the ad id, and then we are creatnig an array called audience that will contain all
    documents that have the same _id.ad value. 

    reorganize_regions: 
        This function will look inside of the facebook_regions_*county* collection and organize the location data
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

def reorganize_audience(collection):
    print("Reorganizing " + collection.name)
    query = [
        {
            "$group" : {
                "_id": "$_id.ad",
                "audience" : {
                    "$push" : { 
                        "_id": "$_id",
                        "percentage": '$percentage'
                    }
                }
            }
        }
    ]
    documents = collection.aggregate(query)

    for doc in documents:
        try:
            collection.insert_one(doc)
        except DuplicateKeyError:
            pass
    
def reorganize_regions(region_collection, ad_collection):
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
    audience_collection = db["facebook_audiences_" + country]
    ad_collection = db["facebook_ads_" + country]
    from pymongo import MongoClient

    reorganize_audience(audience_collection)
    reorganize_regions(region_collection, ad_collection)
    
    # Close the MongoDB connection
    client.close()


