import os
from fb_ads_library_api import FbAdsLibraryTraversal
from datetime import date, datetime, timedelta
import pymongo
from time import sleep
import sys
import requests
import json

api_key = os.environ.get("FACEBOOK_API_KEY")

if not api_key:
    print("API key not set. Please set the FACEBOOK_API_KEY environment variable.")
    sys.exit(1)

to_dt = lambda text: datetime.strptime(
        text,
        '%Y-%m-%d'
    )

db = pymongo.MongoClient()['polidashboard']

def update_ad(ad, country):
    doc = {
        '_id': ad['id'],
        'creation_time': to_dt(ad['ad_creation_time'])
            if 'ad_creation_time' in ad else None,
        'creative_bodies': ad['ad_creative_bodies'] 
            if 'ad_creative_bodies' in ad else None,
        'creative_link_captions': ad['ad_creative_link_captions'] 
            if 'ad_creative_link_captions' in ad else None,
        'creative_link_descriptions': ad['ad_creative_link_descriptions']
            if 'ad_creative_link_descriptions' in ad else None,
        'creative_link_titles': ad['ad_creative_link_titles']
            if 'ad_creative_link_titles' in ad else None,
        'delivery_start_time': to_dt(ad['ad_delivery_start_time'])
            if 'ad_delivery_start_time' in ad else None,
        'delivery_stop_time': to_dt(ad['ad_delivery_stop_time'])
            if 'ad_delivery_stop_time' in ad else None,
        'snapshot_url': ad['ad_snapshot_url']
            if 'ad_snapshot_url' in ad else None,
        'currency': ad['currency']
            if 'currency' in ad else None,
        'impressions': {
            'lower_bound': int(ad['impressions']['lower_bound'])
                if 'impressions' in ad and 'lower_bound' in ad['impressions'] else None,
            'upper_bound': int(ad['impressions']['upper_bound'])
                if 'impressions' in ad and 'upper_bound' in ad['impressions'] else None
        },
        'languages': ad['languages']
            if 'languages' in ad else None,
        'page_id': ad['page_id'],
        'funding_entity': ad['bylines']
            if 'bylines' in ad else None,
        'spend': {
            'lower_bound': int(ad['spend']['lower_bound'])
                if 'spend' in ad and 'lower_bound' in ad['spend'] else None,
            'upper_bound': int(ad['spend']['upper_bound'])
                if 'spend' in ad and 'upper_bound' in ad['spend'] else None
        },
        'publisher_platforms': ad['publisher_platforms']
            if 'publisher_platforms' in ad else None,
        'target_locations': ad['target_locations']
            if 'target_locations' in ad else None,
        'target_gender': ad['target_gender']
            if 'target_gender' in ad else None,   
        'target_ages': ad['target_ages']
            if 'target_ages' in ad else None,  
        'estimated_audience_size': ad['estimated_audience_size']
            if 'estimated_audience_size' in ad else None,
        'latest_collected': datetime.now()
    }

    # delivery_by_region won't always exist within the document, so we need to check for it
    delivery_by_region = {}
    if 'delivery_by_region' in ad:
        for reg in ad['delivery_by_region']:
            delivery_by_region[reg['region']] = float(reg['percentage'])
        doc['delivery_by_region'] = delivery_by_region
    else:
        doc['delivery_by_region'] = None
        
    db['facebook_ads_' + country].update_one({
        '_id': doc['_id']
    }, {
        '$set': doc,
        '$setOnInsert': {
            'first_collected': datetime.now()
        }
    }, upsert=True)
    return True

def update_timestamp(ad, country):
    db['facebook_timestamps_' + country].insert_one({
        '_id': {
            'ad': ad['id'],
            'timestamp': datetime.now()
        }
    })

def update_audiences(ad, country):
    if 'demographic_distribution' in ad:
        for audience in ad['demographic_distribution']:
            db['facebook_audiences_' + country].update_one({
                '_id': ad['id'],
            }, {
                '$addToSet' : { 
                    'audience' : {
                        '_id': { # It is important for these fields to be in this exact order
                            'ad': ad['id'],
                            'age': audience['age'],
                            'gender': audience['gender']
                        },
                        'percentage': float(audience['percentage'])
                    }
                }
            }, upsert=True)

            # update the audience values in case they have been updated
            filter_criteria = {
                '_id': ad['id'],
                'audience._id': {
                    'ad': ad['id'],
                    'age': audience['age'],
                    'gender': audience['gender']
                }
            }

            update_data = {
                '$set': {
                    'audience.$.percentage': float(audience['percentage'])
                }
            }
            db['facebook_audiences_' + country].update_one(filter_criteria, update_data, upsert=True)

            db['facebook_demographics_' + country].update_one({
                '_id': ad['id'],
            }, {
                '$set': {
                    f'{audience["gender"]}.{audience["age"]}': float(audience['percentage'])
                }
            }, upsert=True)

def update_regions(ad, country):
    if 'delivery_by_region' in ad:
        for region in ad['delivery_by_region']:
            db['facebook_regions_'  + country].update_one({
                '_id': {
                    'ad': ad['id'],
                    'region': region['region']
                }
            }, {
                '$set': {
                    'percentage': float(region['percentage'])
                }
            }, upsert=True)

def update_page(ad, country):
    page_name = ad.get('page_name', '')
    data_to_set = {
        'name': page_name
    }
    if page_name == '':
        data_to_set['is_empty'] = True
    db['facebook_pages_' + country].update_one({
        '_id': ad['page_id']
    }, {
        '$set': data_to_set
    }, upsert=True)

def ensure_indices(country):
    db['facebook_timestamps_' + country].create_index('_id.timestamp')
    db['facebook_audiences_' + country].create_index('_id.ad')
    db['facebook_regions_'  + country].create_index('_id.ad')
    db['facebook_ads_'  + country].create_index('funding_entity')
    db['facebook_ads_'  + country].create_index('currency')    
    db['facebook_ads_' + country].create_index([('first_collected', pymongo.ASCENDING), ('latest_collected', pymongo.ASCENDING)])
    db['facebook_ads_' + country].create_index([
        ('delivery_stop_time', pymongo.ASCENDING),
        ('latest_collected', pymongo.ASCENDING),
        ('delivery_start_time', pymongo.ASCENDING)
    ])
    db['facebook_ads_' + country].create_index([
        ('delivery_stop_time', pymongo.ASCENDING),
        ('delivery_start_time', pymongo.ASCENDING)
    ])


if __name__=="__main__":
    try:
        country = sys.argv[1]
    except IndexError:
        print('No country given')
        exit()

    print('Running ', country, datetime.now())

    page_limit = 100
    
    after_date = datetime.now() - timedelta(days=2) # Only get ads from the last 2 days
    after_date = after_date.strftime('%Y-%m-%d')

    n = 0
    collector = FbAdsLibraryTraversal(
        api_key,
        "id,ad_creation_time,ad_creative_bodies,ad_creative_link_captions,ad_creative_link_descriptions,ad_creative_link_titles,ad_delivery_start_time,ad_delivery_stop_time,ad_snapshot_url,currency,delivery_by_region,demographic_distribution,bylines,impressions,languages,page_id,page_name,publisher_platforms,spend,target_locations,target_gender,target_ages,estimated_audience_size",
        ".",
        # "''",
        country,
        after_date=after_date,
        # cutoff_after_date=after_date,
        page_limit=page_limit,
        api_version="v21.0" # Current version as of Oct 2024
    )

    n = 0
    for ads in collector.generate_ad_archives():
        for ad in ads:
            print(ad)
            update_ad(ad, country)
            update_audiences(ad, country)
            update_page(ad, country)
            update_timestamp(ad, country)
            n += 1
    
    print(f'Got {n} ads | on {str(datetime.now())}')

    ensure_indices(country)
    print('Done')
