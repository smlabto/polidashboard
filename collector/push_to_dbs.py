# This script contains class responsible for converting Meta's ad data into SQL
# It is necessary to define your environment variables in a .env file or in your current session
# Replacting the add_env_variable_file_location with the path to your .env file

# By default, ssh tunneling is disabled, if you want to use it, set the use_tunnel parameter to True
# When initializing the SQLInserter class.

import os
import psycopg2
import traceback
import math
from datetime import datetime
from dotenv import load_dotenv
from sshtunnel import SSHTunnelForwarder


def load_sql_env():
    load_dotenv("add_env_variable_file_location")

    # Load SSH credentials from environment variables
    return {
        "pg_user": os.environ.get("PG_USER", "polidashboard-admin"),
        "pg_password": os.environ.get("PG_PASSWORD", "admin"),
        "pg_host": os.environ.get("PG_HOST", "localhost"),
        "pg_database": os.environ.get("PG_DATABASE", "polidashboard"),
        "pg_port": int(os.environ.get("PG_PORT", 5432)),
        "ssh_host": os.environ.get("SSH_HOST", ""),
        "ssh_port": int(os.environ.get("SSH_PORT", 22)),
        "ssh_username": os.environ.get("SSH_USERNAME", ""),
        "ssh_password": os.environ.get("SSH_PASSWORD", ""),
    }


def remove_nul_chars(value):
    if isinstance(value, str):
        return value.replace("\x00", "")
    return value


class SQLInserter:
    def __init__(self, country, use_tunnel=False):
        self.country = country
        self.env = load_sql_env()
        self.connection = None
        self.cursor = None
        self.tunnel = None
        if use_tunnel:
            try:
                self.tunnel = SSHTunnelForwarder(
                    (self.env["ssh_host"], self.env["ssh_port"]),
                    ssh_username=self.env["ssh_username"],
                    ssh_password=self.env["ssh_password"],
                    remote_bind_address=(self.env["pg_host"], self.env["pg_port"]),
                )
                self.tunnel.start()
            except Exception as e:
                print("Failed to start SSH tunnel:", e)
                traceback.print_exc()
                self.tunnel = None

        self.connect_db()

    def connect_db(self):
        try:
            host = "127.0.0.1" if self.tunnel else self.env["pg_host"]
            port = self.tunnel.local_bind_port if self.tunnel else self.env["pg_port"]

            self.connection = psycopg2.connect(
                host=host,
                port=port,
                user=self.env["pg_user"],
                password=self.env["pg_password"],
                # dbname="polidashboard_tunnel_test",
                dbname=self.env["pg_database"],
            )
            self.cursor = self.connection.cursor()
            self.cursor.execute("SET client_encoding TO 'utf8'")
            self.connection.commit()
            print(self.env["pg_database"])
            print("Postgres database connection established!")
        except Exception as e:
            print("Database connection error:", e)
            traceback.print_exc()

    def get_ids(self):
        try:
            self.cursor.execute(
                "SELECT id FROM ad_data WHERE country = %s AND bylines_name IS NOT NULL", (self.country,)
            )
            ids = [str(row[0]) for row in self.cursor.fetchall()]
            print(f"Total ids in {self.country}: {len(ids)}")
            return ids
        except Exception as e:
            print("Error fetching ids for sql:", e)
            traceback.print_exc()
            return []

    def get_counts(self, region=False, demographic=False):
        try:
            if region:
                self.cursor.execute(
                    "SELECT COUNT(DISTINCT id) FROM ad_region WHERE country = %s", (self.country,)
                )
            elif demographic:
                self.cursor.execute(
                    "SELECT COUNT(DISTINCT id) FROM ad_demographic WHERE country = %s", (self.country,)
                )
            else:
                self.cursor.execute(
                    "SELECT COUNT(*) FROM ad_data WHERE country = %s AND bylines_name IS NOT NULL", (self.country,)
                )
            count = self.cursor.fetchone()[0]
            print(f"Total ads in {self.country}: {count}")
            return count
        except Exception as e:
            print("Error fetching counts for sql:", e)
            traceback.print_exc()
            return 0

    def insert_ad(self, fb_ad, check_latest=False):
        try:
            latest_collected_check = True
            if "latest_collected" in fb_ad:
                check_latest_collected_query = "SELECT latest_collected FROM ad_data WHERE country = %s AND id = %s"
                self.cursor.execute(
                    check_latest_collected_query,
                    (
                        self.country,
                        fb_ad["id"],
                    ),
                )
                result = self.cursor.fetchone()
                latest_collected = fb_ad["latest_collected"]
                if isinstance(latest_collected, str):
                    latest_collected = datetime.strptime(
                        latest_collected, "%Y-%m-%dT%H:%M:%S"
                    )
                if result and result[0] is not None and result[0] > latest_collected:
                    latest_collected_check = False

            if latest_collected_check:
                bylines_name = None
                if "bylines" in fb_ad:
                    bylines_name = fb_ad.get("bylines")[:1000]

                page_id = None
                page_name = None
                # Upsert page_id, page_name, and country into page_table
                if "page_id" in fb_ad and "page_name" in fb_ad:
                    page_id = fb_ad.get("page_id")
                    page_name = fb_ad.get("page_name")[:1000]

                facebook, instagram, other_platform = False, False, False
                if "publisher_platforms" in fb_ad:
                    for platform in fb_ad["publisher_platforms"]:
                        if platform == "facebook":
                            facebook = True
                        elif platform == "instagram":
                            instagram = True
                        else:
                            other_platform = True 

                ad_data = {
                    "id": fb_ad.get("id") if "id" in fb_ad else None,
                    "ad_creation_time": (
                        fb_ad.get("ad_creation_time")
                        if "ad_creation_time" in fb_ad
                        else None
                    ),
                    "ad_creative_body": (
                        fb_ad.get("ad_creative_body")
                        if "ad_creative_body" in fb_ad
                        else None
                    ),
                    "ad_creative_link_captions": (
                        fb_ad.get("ad_creative_link_captions")
                        if "ad_creative_link_captions" in fb_ad
                        else None
                    ),
                    "ad_creative_link_descriptions": (
                        fb_ad.get("ad_creative_link_descriptions")
                        if "ad_creative_link_descriptions" in fb_ad
                        else None
                    ),
                    "ad_creative_link_titles": (
                        fb_ad.get("ad_creative_link_titles")
                        if "ad_creative_link_titles" in fb_ad
                        else None
                    ),
                    "ad_delivery_start_time": (
                        fb_ad.get("ad_delivery_start_time")
                        if "ad_delivery_start_time" in fb_ad
                        else None
                    ),
                    "ad_delivery_stop_time": (
                        fb_ad.get("ad_delivery_stop_time")
                        if "ad_delivery_stop_time" in fb_ad and fb_ad.get("ad_delivery_stop_time", False)
                        else (
                            fb_ad.get("latest_collected")
                            if "latest_collected" in fb_ad
                            else datetime.now()
                        )
                    ),
                    "ad_delivery_stop_time_raw" : (fb_ad.get("ad_delivery_stop_time")
                        if "ad_delivery_stop_time" in fb_ad
                        else None
                    ),
                    "ad_snapshot_url": (
                        fb_ad.get("ad_snapshot_url")
                        if "ad_snapshot_url" in fb_ad
                        else None
                    ),
                    "currency": (
                        fb_ad.get("currency")[:10] if "currency" in fb_ad else None
                    ),
                    "impressions_lower_bound": (
                        fb_ad.get("impressions", {}).get("lower_bound")
                        if "impressions" in fb_ad
                        and "lower_bound" in fb_ad["impressions"]
                        else None
                    ),
                    "impressions_upper_bound": (
                        fb_ad.get("impressions", {}).get("upper_bound")
                        if "impressions" in fb_ad
                        and "upper_bound" in fb_ad["impressions"]
                        else None
                    ),
                    "languages": (
                        fb_ad.get("languages") if "languages" in fb_ad else None
                    ),
                    "page_id": page_id,
                    "page_name": page_name,
                    "bylines_name": bylines_name,
                    "spend_lower_bound": (
                        fb_ad.get("spend", {}).get("lower_bound")
                        if "spend" in fb_ad and "lower_bound" in fb_ad["spend"]
                        else None
                    ),
                    "spend_upper_bound": (
                        fb_ad.get("spend", {}).get("upper_bound")
                        if "spend" in fb_ad and "upper_bound" in fb_ad["spend"]
                        else None
                    ),
                    "audience_lower_bound": (
                        fb_ad.get("estimated_audience_size", {}).get("lower_bound")
                        if "estimated_audience_size" in fb_ad
                        and "lower_bound" in fb_ad["estimated_audience_size"]
                        else None
                    ),
                    "audience_upper_bound": (
                        fb_ad.get("estimated_audience_size", {}).get("upper_bound")
                        if "estimated_audience_size" in fb_ad
                        and "upper_bound" in fb_ad["estimated_audience_size"]
                        else None
                    ),
                    "latest_collected": (
                        fb_ad.get("latest_collected")
                        if "latest_collected" in fb_ad
                        else datetime.now()
                    ),
                    "languages": (
                        fb_ad.get("languages") if "languages" in fb_ad else None
                    ),
                    "platforms_facebook": facebook,
                    "platforms_instagram": instagram,
                    "platforms_other": other_platform,
                    "platforms": (
                        fb_ad.get("publisher_platforms")
                        if "publisher_platforms" in fb_ad
                        else None
                    ),
                }
                upsert_ad_data_query = """
                INSERT INTO ad_data (
                    id, ad_creation_time,
                    ad_delivery_start_time, ad_delivery_stop_time,ad_delivery_stop_time_raw,latest_collected, ad_snapshot_url, currency, country, impressions_lower_bound,
                    impressions_upper_bound, page_id, page_name, bylines_name, spend_lower_bound, spend_upper_bound,
                    audience_lower_bound, audience_upper_bound, languages, platforms_facebook, platforms_instagram, platforms_other, platforms
                ) VALUES (%s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (id, country) DO UPDATE SET
                    ad_creation_time = EXCLUDED.ad_creation_time,
                    ad_delivery_start_time = EXCLUDED.ad_delivery_start_time,
                    ad_delivery_stop_time = EXCLUDED.ad_delivery_stop_time,
                    ad_delivery_stop_time_raw = EXCLUDED.ad_delivery_stop_time_raw,
                    latest_collected = EXCLUDED.latest_collected,
                    ad_snapshot_url = EXCLUDED.ad_snapshot_url,
                    currency = EXCLUDED.currency,
                    impressions_lower_bound = EXCLUDED.impressions_lower_bound,
                    impressions_upper_bound = EXCLUDED.impressions_upper_bound,
                    page_id = EXCLUDED.page_id,
                    page_name = EXCLUDED.page_name,
                    bylines_name = EXCLUDED.bylines_name,
                    spend_lower_bound = EXCLUDED.spend_lower_bound,
                    spend_upper_bound = EXCLUDED.spend_upper_bound,
                    audience_lower_bound = EXCLUDED.audience_lower_bound,
                    audience_upper_bound = EXCLUDED.audience_upper_bound,
                    languages = EXCLUDED.languages,
                    platforms_facebook = EXCLUDED.platforms_facebook,
                    platforms_instagram = EXCLUDED.platforms_instagram,
                    platforms_other = EXCLUDED.platforms_other,
                    platforms = EXCLUDED.platforms
                """
                self.cursor.execute(
                    upsert_ad_data_query,
                    (
                        ad_data["id"],
                        ad_data["ad_creation_time"],
                        ad_data["ad_delivery_start_time"],
                        ad_data["ad_delivery_stop_time"],
                        ad_data["ad_delivery_stop_time_raw"],
                        ad_data["latest_collected"],
                        ad_data["ad_snapshot_url"],
                        ad_data["currency"],
                        self.country,
                        ad_data["impressions_lower_bound"],
                        ad_data["impressions_upper_bound"],
                        ad_data["page_id"],
                        ad_data["page_name"],
                        ad_data["bylines_name"],
                        ad_data["spend_lower_bound"],
                        ad_data["spend_upper_bound"],
                        ad_data["audience_lower_bound"],
                        ad_data["audience_upper_bound"],
                        ad_data["languages"],
                        ad_data["platforms_facebook"],
                        ad_data["platforms_instagram"],
                        ad_data["platforms_other"],
                        ad_data["platforms"],
                    ),
                )
                upsert_ad_creative_content = """
                INSERT INTO ad_creative_content (
                    id, content_order, body, caption, descript, title, country,
                    ad_delivery_start_time, ad_delivery_stop_time, latest_collected, platforms_facebook, platforms_instagram, platforms_other, platforms, bylines_name, page_id, page_name,ad_snapshot_url
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (id,country, content_order) DO UPDATE SET
                    body = EXCLUDED.body,
                    caption = EXCLUDED.caption,
                    descript = EXCLUDED.descript,
                    title = EXCLUDED.title,
                    ad_delivery_start_time = EXCLUDED.ad_delivery_start_time,
                    ad_delivery_stop_time = EXCLUDED.ad_delivery_stop_time,
                    latest_collected = EXCLUDED.latest_collected,
                    page_id = EXCLUDED.page_id,
                    page_name = EXCLUDED.page_name,
                    bylines_name = EXCLUDED.bylines_name,
                    platforms_facebook = EXCLUDED.platforms_facebook,
                    platforms_instagram = EXCLUDED.platforms_instagram,
                    platforms_other = EXCLUDED.platforms_other,
                    platforms = EXCLUDED.platforms,
                    ad_snapshot_url = EXCLUDED.ad_snapshot_url
                """

                max_length = max(
                    len(fb_ad.get("ad_creative_bodies") or []),
                    len(fb_ad.get("ad_creative_link_captions") or []),
                    len(fb_ad.get("ad_creative_link_descriptions") or []),
                    len(fb_ad.get("ad_creative_link_titles") or []),
                )

                for i in range(max_length):
                    body = (
                        remove_nul_chars(fb_ad.get("ad_creative_bodies")[i])
                        if i < len(fb_ad.get("ad_creative_bodies", []))
                        else None
                    )
                    caption = (
                        remove_nul_chars(fb_ad.get("ad_creative_link_captions")[i])
                        if i < len(fb_ad.get("ad_creative_link_captions", []))
                        else None
                    )
                    descript = (
                        remove_nul_chars(fb_ad.get("ad_creative_link_descriptions")[i])
                        if i < len(fb_ad.get("ad_creative_link_descriptions", []))
                        else None
                    )
                    title = (
                        remove_nul_chars(fb_ad.get("ad_creative_link_titles")[i])
                        if i < len(fb_ad.get("ad_creative_link_titles", []))
                        else None
                    )

                    self.cursor.execute(
                        upsert_ad_creative_content,
                        (
                            ad_data["id"],
                            i + 1,
                            body,
                            caption,
                            descript,
                            title,
                            self.country,
                            ad_data["ad_delivery_start_time"],
                            ad_data["ad_delivery_stop_time"],
                            ad_data["latest_collected"],
                            ad_data["platforms_facebook"],
                            ad_data["platforms_instagram"],
                            ad_data["platforms_other"],
                            ad_data["platforms"],
                            ad_data["bylines_name"],
                            ad_data["page_id"],
                            ad_data["page_name"],
                            ad_data["ad_snapshot_url"],
                        ),
                    )
                    
                upsert_ad_region_query = """
                INSERT INTO ad_region (
                    id, region, region_percent, region_impressions_lower_bound, region_impressions_upper_bound, region_spend_lower_bound, region_spend_upper_bound, country,
                    ad_delivery_start_time, ad_delivery_stop_time, latest_collected, platforms_facebook, platforms_instagram, platforms_other, platforms, bylines_name, page_id, page_name
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (id, country, region) DO UPDATE SET
                    region_percent = EXCLUDED.region_percent,
                    region_impressions_lower_bound = EXCLUDED.region_impressions_lower_bound,
                    region_impressions_upper_bound = EXCLUDED.region_impressions_upper_bound,
                    region_spend_lower_bound = EXCLUDED.region_spend_lower_bound,
                    region_spend_upper_bound = EXCLUDED.region_spend_upper_bound,
                    ad_delivery_start_time = EXCLUDED.ad_delivery_start_time,
                    ad_delivery_stop_time = EXCLUDED.ad_delivery_stop_time,
                    latest_collected = EXCLUDED.latest_collected,
                    page_id = EXCLUDED.page_id,
                    page_name = EXCLUDED.page_name,
                    bylines_name = EXCLUDED.bylines_name,
                    platforms_facebook = EXCLUDED.platforms_facebook,
                    platforms_instagram = EXCLUDED.platforms_instagram,
                    platforms_other = EXCLUDED.platforms_other,
                    platforms = EXCLUDED.platforms
                """
                if "delivery_by_region" in fb_ad:
                    for region in fb_ad["delivery_by_region"]:
                        region_percent = float(region.get("percentage"))
                        region_name = region.get("region")
                        region_impressions_lower_bound = None
                        region_impressions_upper_bound = None
                        region_spend_lower_bound = None
                        region_spend_upper_bound = None
                        if ad_data["impressions_lower_bound"] is not None:
                            region_impressions_lower_bound = region_percent * float(
                                ad_data["impressions_lower_bound"])
                        if ad_data["impressions_upper_bound"] is not None:
                            region_impressions_upper_bound = region_percent * float(
                                ad_data["impressions_upper_bound"]
                            )
                        if ad_data["spend_lower_bound"] is not None:
                            region_spend_lower_bound = region_percent * float(
                                ad_data["spend_lower_bound"]
                            )
                        if ad_data["spend_upper_bound"] is not None:
                            region_spend_upper_bound = region_percent * float(
                                ad_data["spend_upper_bound"]
                            )

                        self.cursor.execute(
                            upsert_ad_region_query,
                            (
                                ad_data["id"],
                                region_name,
                                region_percent,
                                region_impressions_lower_bound,
                                region_impressions_upper_bound,
                                region_spend_lower_bound,
                                region_spend_upper_bound,
                                self.country,
                                ad_data["ad_delivery_start_time"],
                                ad_data["ad_delivery_stop_time"],
                                ad_data["latest_collected"],
                                ad_data["platforms_facebook"],
                                ad_data["platforms_instagram"],
                                ad_data["platforms_other"],
                                ad_data["platforms"],
                                ad_data["bylines_name"],
                                ad_data["page_id"],
                                ad_data["page_name"]
                            ),
                        )


                upsert_ad_demographics_query = """
                INSERT INTO ad_demographic (
                    id, country, gender, age_range, age_percent, age_impressions_lower_bound, age_impressions_upper_bound, age_spend_lower_bound, age_spend_upper_bound, 
                    ad_delivery_start_time, ad_delivery_stop_time, latest_collected, platforms_facebook, platforms_instagram, platforms_other, platforms, bylines_name, page_id, page_name
                ) VALUES (%s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (id,country, gender, age_range) DO UPDATE SET
                    age_percent = EXCLUDED.age_percent,
                    age_impressions_lower_bound = EXCLUDED.age_impressions_lower_bound,
                    age_impressions_upper_bound = EXCLUDED.age_impressions_upper_bound,
                    age_spend_lower_bound = EXCLUDED.age_spend_lower_bound,
                    age_spend_upper_bound = EXCLUDED.age_spend_upper_bound,
                    ad_delivery_start_time = EXCLUDED.ad_delivery_start_time,
                    ad_delivery_stop_time = EXCLUDED.ad_delivery_stop_time,
                    latest_collected = EXCLUDED.latest_collected,
                    page_id = EXCLUDED.page_id,
                    page_name = EXCLUDED.page_name,
                    bylines_name = EXCLUDED.bylines_name,
                    platforms_facebook = EXCLUDED.platforms_facebook,
                    platforms_instagram = EXCLUDED.platforms_instagram,
                    platforms_other = EXCLUDED.platforms_other,
                    platforms = EXCLUDED.platforms
                """
                if "demographic_distribution" in fb_ad:
                    for demographic in fb_ad["demographic_distribution"]:
                        age_range_percent = float(demographic.get("percentage"))
                        age_range = demographic.get("age")
                        gender = demographic.get("gender")
                        age_impressions_lower_bound = None
                        age_impressions_upper_bound = None
                        age_spend_lower_bound = None
                        age_spend_upper_bound = None
                        if ad_data["impressions_lower_bound"] is not None:
                            age_impressions_lower_bound = age_range_percent * float(
                                ad_data["impressions_lower_bound"]
                            )
                        if ad_data["impressions_upper_bound"] is not None:
                            age_impressions_upper_bound = age_range_percent * float(
                                ad_data["impressions_upper_bound"]
                            )
                        if ad_data["spend_lower_bound"] is not None:
                            age_spend_lower_bound = age_range_percent * float(
                                ad_data["spend_lower_bound"]
                            )
                        if ad_data["spend_upper_bound"] is not None:
                            age_spend_upper_bound = age_range_percent * float(
                                ad_data["spend_upper_bound"]
                            )

                        self.cursor.execute(
                            upsert_ad_demographics_query,
                            (
                                ad_data["id"],
                                self.country,
                                gender,
                                age_range,
                                age_range_percent,
                                age_impressions_lower_bound,
                                age_impressions_upper_bound,
                                age_spend_lower_bound,
                                age_spend_upper_bound,
                                ad_data["ad_delivery_start_time"],
                                ad_data["ad_delivery_stop_time"],
                                ad_data["latest_collected"],
                                ad_data["platforms_facebook"],
                                ad_data["platforms_instagram"],
                                ad_data["platforms_other"],
                                ad_data["platforms"],
                                ad_data["bylines_name"],
                                ad_data["page_id"],
                                ad_data["page_name"]
                            ),
                        )
                        
                self.connection.commit()

            ad_id_print = str(fb_ad["id"])
            print(f"Added / updated ad in PSQL: {ad_id_print}")
        except Exception as e:
            self.connection.rollback()
            print(f"Error: {e}")
            traceback.print_exc()

        return f"Successfully added ad"

    def close_db(self):
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        if self.tunnel:
            try:
                self.tunnel.stop()
            except:
                pass

    def __del__(self):
        self.close_db()