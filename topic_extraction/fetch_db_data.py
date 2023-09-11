from pymongo import MongoClient
import pandas as pd
import json


def return_client_and_db(mongo_uri='mongodb://localhost:27017'):
    # establish a connection to the database mongodb://localhost:27017
    client = MongoClient()
    db = client.polidashboard
    return client, db


def fetch_page(db, country, page_id):
    pages_collection = db[f"facebook_pages_{country}"]
    page = pages_collection.find_one({"_id": page_id})
    return page


def fetch_ads(db, country, page_id, start_time, end_time):
    ads_collection = db[f"facebook_ads_{country}"]
    ads = ads_collection.find({"page_id": page_id,
                               "first_collected": {"$gte": start_time},
                               "latest_collected": {"$lte": end_time}})
    # convert to a list of dictionaries
    ads = list(ads)
    return ads


def merge_page_name_with_associated_ads(ads, page_name):
    for ad in ads:
        ad["page_name"] = page_name

    # convert creative_bodies to str
    for ad in ads:
        creative_bodies_combined = ""
        for creative_body in ad["creative_bodies"]:
            creative_bodies_combined += " " + creative_body
        ad["creative_bodies"] = creative_bodies_combined
    return ads


def close_connection(client):
    client.close()


if __name__ == '__main__':
    client, db = return_client_and_db()
    country = "us"
    page_id = "107661474402498"
    start_time = "1970-08-23T11:31:07.676+00:00"
    # convert start_time to datetime object
    start_time = pd.to_datetime(start_time)

    end_time = "2023-08-29T11:31:07.676+00:00"
    # convert end_time to datetime object
    end_time = pd.to_datetime(end_time)

    page_name = fetch_page(db, country, page_id)
    ads = fetch_ads(db, country, page_id, start_time, end_time)

    ads = merge_page_name_with_associated_ads(ads, page_name)

    close_connection(client)
