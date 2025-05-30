DROP TABLE IF EXISTS ad_region CASCADE;
DROP TABLE IF EXISTS ad_demographic CASCADE;
DROP TABLE IF EXISTS ad_creative_content CASCADE;

DROP TABLE IF EXISTS ad_data CASCADE;

-- Main ad data table, columns don't need indexes as they are not used for filtering
CREATE TABLE ad_data(
    id BIGINT,
    ad_creation_time TIMESTAMP NULL,
    ad_delivery_start_time TIMESTAMP NULL,
    ad_delivery_stop_time TIMESTAMP NULL,
    ad_delivery_stop_time_raw TIMESTAMP NULL,
    latest_collected TIMESTAMP NULL,
    ad_snapshot_url VARCHAR(1100),
    currency VARCHAR(10),
    country VARCHAR(2),
    impressions_lower_bound INT,
    impressions_upper_bound INT,
    page_id BIGINT,
    page_name VARCHAR(1000),
    bylines_name VARCHAR(1000),
    spend_lower_bound INT,
    spend_upper_bound INT,
    audience_lower_bound INT,
    audience_upper_bound INT,
    languages TEXT[],
    platforms_facebook BOOLEAN,
    platforms_instagram BOOLEAN,
    platforms_other BOOLEAN,
    platforms TEXT[],
    PRIMARY KEY (id, country)
) PARTITION BY LIST (country);

-- Creative content data, separated from ad_data to allow for multiple creatives per ad
CREATE TABLE ad_creative_content(
    id BIGINT,
    country VARCHAR(2),
    currency VARCHAR(10),
    content_order INT,
    body TEXT,
    caption TEXT,
    descript TEXT,
    title TEXT,
    ad_delivery_start_time TIMESTAMP NULL,
    ad_delivery_stop_time TIMESTAMP NULL,
    latest_collected TIMESTAMP NULL,
    platforms_facebook BOOLEAN,
    platforms_instagram BOOLEAN,
    platforms_other BOOLEAN,
    platforms TEXT[],
    page_id BIGINT,
    page_name VARCHAR(1000),
    bylines_name VARCHAR(1000),
    ad_snapshot_url VARCHAR(1100),
    PRIMARY KEY (id,country, content_order)
) PARTITION BY LIST (country);

-- Region data, filter this table to find ads targeted at specific regions
CREATE TABLE ad_region (
    id BIGINT,
    country VARCHAR(2),
    currency VARCHAR(10),
    region VARCHAR(100),
    region_percent DECIMAL(7, 6),
    region_impressions_lower_bound DECIMAL(16, 6),
    region_impressions_upper_bound DECIMAL(16, 6),
    region_spend_lower_bound DECIMAL(16, 6),
    region_spend_upper_bound DECIMAL(16, 6),
    ad_delivery_start_time TIMESTAMP NULL,
    ad_delivery_stop_time TIMESTAMP NULL,
    latest_collected TIMESTAMP NULL,
    platforms_facebook BOOLEAN,
    platforms_instagram BOOLEAN,
    platforms_other BOOLEAN,
    platforms TEXT[],
    page_id BIGINT,
    page_name VARCHAR(1000),
    bylines_name VARCHAR(1000),
    PRIMARY KEY (id,country, region)
) PARTITION BY LIST (country);

-- Demographic data, filter this table to find ads targeted at specific demographics
CREATE TABLE ad_demographic (
    id BIGINT,
    country VARCHAR(2),
    currency VARCHAR(10),
    gender VARCHAR(20),
    age_range VARCHAR(50),
    age_percent DECIMAL(7, 6),
    age_impressions_lower_bound DECIMAL(16, 6),
    age_impressions_upper_bound DECIMAL(16, 6),
    age_spend_lower_bound DECIMAL(16, 6),
    age_spend_upper_bound DECIMAL(16, 6),
    ad_delivery_start_time TIMESTAMP NULL,
    ad_delivery_stop_time TIMESTAMP NULL,
    latest_collected TIMESTAMP NULL,
    platforms_facebook BOOLEAN,
    platforms_instagram BOOLEAN,
    platforms_other BOOLEAN,
    platforms TEXT[],
    page_id BIGINT,
    page_name VARCHAR(1000),
    bylines_name VARCHAR(1000),
    PRIMARY KEY (id, country, gender, age_range)
) PARTITION BY LIST (country);