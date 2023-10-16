from pymongo import MongoClient
import pandas as pd
import generate_wordcloud
import process_ads


def return_client_and_db(mongo_uri='mongodb://localhost:27017'):
    # establish a connection to the database mongodb://localhost:27017
    client = MongoClient()
    db = client.polidashboard
    return client, db


def fetch_page(db, country, page_id):
    pages_collection = db[f"facebook_pages_{country}"]
    page = pages_collection.find_one({"_id": page_id})
    return page


def fetch_ads(db, country, funding_entity, page_id, start_time, end_time):
    ads_collection = db[f"facebook_ads_{country}"]
    if page_id is not None and funding_entity is None:
        ads = ads_collection.find({"page_id": page_id,
                                   "first_collected": {"$gte": start_time},
                                   "latest_collected": {"$lte": end_time}})
    if page_id is None and funding_entity is not None:
        ads = ads_collection.find({"funding_entity": funding_entity,
                                   "first_collected": {"$gte": start_time},
                                   "latest_collected": {"$lte": end_time}})
    # convert to a list of dictionaries
    ads = list(ads)
    # merge multiple creative_bodies into one
    ads = merge_multiple_creative_bodies(ads)
    return ads


def merge_page_name_with_associated_ads(ads, page_name):
    for ad in ads:
        ad["page_name"] = page_name
    return ads

def merge_multiple_creative_bodies(ads):
    # convert creative_bodies to str
    for ad in ads:
        creative_bodies_combined = ""
        for creative_body in ad["creative_bodies"]:
            creative_bodies_combined += " " + creative_body
        ad["creative_bodies"] = creative_bodies_combined
    return ads


def create_ads_summary_table(ads, max_table_length=100):
    # create a list of dictionaries of unique creative_bodies
    ads_summary_table = []
    for ad in ads:
        # search for the ad dictionary in the ads_summary_table that has the same creative_bodies as the current ad
        found_previous_ad = False
        for unique_ad in ads_summary_table:
            found_previous_ad = True
            if ad["creative_bodies"] == unique_ad["creative_bodies"]:
                unique_ad["freq"] += 1
                unique_ad["ad_ids"].append(ad["_id"])
        # if the ad is not found in the ads_summary_table, add it to the ads_summary_table
        if not found_previous_ad:
            ads_summary_table.append({"creative_bodies": ad["creative_bodies"],
                                      "freq": 1,
                                      "ad_ids": [ad["_id"]],
                                      "funding_entity": ad["funding_entity"],
                                      "snapshot_url": ad["snapshot_url"]})

    # sort the ads_summary_table by frequency
    ads_summary_table = sorted(ads_summary_table, key=lambda x: x["freq"], reverse=True)
    # if the length of the ads_summary_table is greater than max_table_length, then only keep the top max_table_length
    if len(ads_summary_table) > max_table_length:
        ads_summary_table = ads_summary_table[:max_table_length]

    return ads_summary_table


def close_connection(client):
    client.close()


if __name__ == '__main__':
    client, db = return_client_and_db()
    country = "us"
    # page_id = "174057765941"
    page_id = None
    funding_entity = "United Patriot"
    start_time = "1970-08-23T11:31:07.676+00:00"
    # convert start_time to datetime object
    start_time = pd.to_datetime(start_time)

    end_time = "2023-08-29T11:31:07.676+00:00"
    # convert end_time to datetime object
    end_time = pd.to_datetime(end_time)


    # only adding the page name to the ads if page_id is provided
    if page_id is not None:
        page = fetch_page(db, country, page_id)
        if page is not None:
            page_name = page["name"]
        else:
            raise "No page found for the given params"

    ads = fetch_ads(db, country, funding_entity, page_id, start_time, end_time)

    if page_id is not None:
        ads = merge_page_name_with_associated_ads(ads, page_name)

    ads_summary = create_ads_summary_table(ads, max_table_length = 100)

    # if ads is an empty list, raise an exception
    if len(ads) == 0:
        raise "No ads found for the given params"

    is_wordcloud = True
    top_n_keywords = 100
    keyword_share_word_threshold = 0.49
    is_politically_relevant_threshold = 0.75
    top_n_key_phrases = 40
    key_phrase_share_word_threshold = 0.49

    # if ads is an empty list, raise an exception
    if len(ads) == 0:
        raise "No ads found for the given params"

    if is_wordcloud:
        # time it
        import time
        start_time = time.time()
        top_keywords = process_ads.extract_keywords([ad["creative_bodies"] for ad in ads],
                                                    top_n=top_n_keywords,
                                                    similarity_threshold=keyword_share_word_threshold,
                                                    is_politically_relevant_threshold=is_politically_relevant_threshold,
                                                    if_only_politically_relevant=False,
                                                    if_extended_stop_words=False)
        img_base64 = generate_wordcloud.generate_keyword_wordcloud(top_keywords, debug=True)

    else:
        key_phrases = process_ads.extract_top_key_phrase(ads,
                                                         top_n=top_n_key_phrases,
                                                         share_word_threshold=key_phrase_share_word_threshold,
                                                         min_length=2,
                                                         max_length=4)
        img_base64 = generate_wordcloud.generate_phrase_wordcloud(key_phrases, debug=True)

    close_connection(client)
