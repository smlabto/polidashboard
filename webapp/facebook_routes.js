var express = require('express')
var router = express.Router()
const fs = require('fs');
var _ = require('underscore');
var countries = require('./countries.json');
var countryStates = require('./country_states.js');
const https = require("http") //https
const path = require('path');
const cors = require('cors');
const moment = require('moment');
const { match } = require('assert');
const redis = require('redis');

const redisClient = redis.createClient();
redisClient.connect().catch(console.error);

const cacheDuration = 43200; // 12 hours

router.get('/', function(req, res) {
    res.redirect('/meta_ads?country=ca')
})

const jsonFilePath = path.join(__dirname, 'countries.json');
let countryCurrencyMap = {};

try {
  const data = fs.readFileSync(jsonFilePath, 'utf8');
  const countries = JSON.parse(data);

  // Create the dictionary
  countries.forEach(country => {
    if (country.code && country.currency) {
      countryCurrencyMap[country.code] = country.currency;
    }
  });
} catch (err) {
  console.error('Error reading the JSON file:', err);
}

// countryCurrencyMap is now accessible globally
router.currencyMap = countryCurrencyMap;

function convertDateFormat(dateStr) {
    const [month, day, year] = dateStr.split('-');
    return `${year}-${month}-${day}`;
}


function validateStartEnd(s, e) {
    function isValidDateFormat(dateString) {
		const regex = /^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])-(\d{4})$/;
		return regex.test(dateString);
	}

    var start = s;
    var end = e;
    const dateFormat = 'MM-DD-YYYY'
    const today = moment();
    if (start === undefined || end === undefined || !isValidDateFormat(start) || !isValidDateFormat(end)) {
        end = today.format(dateFormat);
        const lastWeek = today.subtract(7, 'days');
        start = lastWeek.format(dateFormat)
    } else {
        var startDay = moment(start, dateFormat)
        var endDay = moment(end, dateFormat)
        if (startDay.isAfter(endDay) || endDay.isAfter(today) | startDay.isBefore(moment('10-10-2023', dateFormat))) {
            end = today.format(dateFormat);
            const lastWeek = today.subtract(7, 'days');
            start = lastWeek.format(dateFormat)
        } else {
            start = startDay.format(dateFormat);
            end = endDay.format(dateFormat);
        }
    }

    return [start, end]
}

router.get('/meta_ads', function (req, res) {
    var dates = validateStartEnd(req.query.startDay, req.query.endDay);
    var start = dates[0];
    var end = dates[1];
    var requested_advertiser = decodeURI(req.query.advertiser);
    if (requested_advertiser == undefined) {
        requested_advertiser = "";
    }


    var country = req.query.country
    if (country == null) {
        country = 'ca'
    }

    var validCountries = []
    var regions = {}
    var firstDay
    for (var c of countries) {
        if (c.code == country) {
            regions = c.regions
            firstDay = c['first date']
            currency = c['currency']
            currencySymbol = c['currency symbol']
        }
        validCountries.push(c.code)
    }

    res.render(
        'index', 
        {
            fbStartDay: start,
            fbEndDay: end,
            days: start-end,
            child: 'facebook_ads',
            country: country,
            countries: countries,
            requested_advertiser: requested_advertiser,
            validCountries: validCountries,
            regions: regions,
            fs: fs,
            firstDay: firstDay,
            currency: currency,
            currencySymbol: currencySymbol,
            country_regions: Array.from(countryStates[country].keys())
        }
    );
})


router.get('/status', function (req, res) {
    res.render(
        'index', 
        {
            child: 'status',
            countries: countries,
            days: 0,
            fs: fs,
            country: ''
        }
    )
})

router.post('/status/country', async function(req, res) {
    var country = req.body.country

    // Ensure country given in request exists within the country list
    if (!countries.some(c=> {return c.code==country})){
        res.send(null);
        return;
    }

    const connection = await getDbConnection();
    const currency = countryCurrencyMap[country]; 

    const query = `
        SELECT *, COUNT(*) OVER () AS total_count
        FROM ad_data
        WHERE country = '${country}' AND currency = '${currency}'
        AND bylines_name IS NOT NULL
        ORDER BY latest_collected DESC
        LIMIT 1;
    `;

    const values = await getData(query, connection);
    
    if (values.length > 0) {
        connection.release();
        return res.send({
            timestamp: values[0].latest_collected,
            total_ads: values[0].total_count
        })
    } else {
        connection.release();
        return res.send({})
    }
})

router.post('/meta_ads/heatmap', async (req, res) => {
    await handleRequest("heatmap", req.body, res, filterAdData);
});

router.post('/meta_ads/funder_pages', async (req, res) => {
    await handleRequest("funder_pages", req.body, res, getFunderPages);
});

router.post('/meta_ads/funder_demographics', async (req, res) => {
    await handleRequest("funder_demographics", req.body, res, getFunderDemographics);
});

router.post('/meta_ads/funder_timeline', async (req, res) => {
    await handleRequest("funder_timeline", req.body, res, getFunderAds);
});

router.post('/meta_ads/funder_map', async (req, res) => {
    await handleRequest("funder_map", req.body, res, getFunderMap);
});

router.post('/meta_ads/frequency_table', async (req, res) => {
    await handleRequest("frequency_table", req.body, res, getFunderFrequency);
});

router.post('/meta_ads/funder_word', async (req, res) => {
    await handleRequest("funder_word", req.body, res, getWordCloud);
});

function buildCacheKey(category, params) {
    return `${category}:${Object.entries(params)
        .map(([key, value]) => `${key}:${Array.isArray(value) ? value.sort().join(',') : value}`)
        .join(':')}`;
}

async function handleRequest(cacheCategory, params, res, dataFunction) {
    try {
        const connection = await getDbConnection();
        try {
            const cacheKey = buildCacheKey(cacheCategory, params);
            const cachedData = await redisClient.get(cacheKey);

            if (cachedData) {
                return res.send(JSON.parse(cachedData));
            }

            const result = await dataFunction(params, connection);
            await redisClient.setEx(cacheKey, cacheDuration, JSON.stringify(result));
            return res.send(result);
        } catch (error) {
            console.error(error);
        } finally {
            connection.release();
        }
    } catch (error) {
        console.error("Connection request timed out:", error);
    }
}

module.exports = router

const psqlHost = "localhost"
const psqlUser = process.env.POSTGRES_USER || "polidashboard-viewer"
const psqlPass = process.env.POSTGRES_PASS || "viewer"
const psqlDb = "polidashboard"
console.log("Connecting to PostgreSQL using:\n Host: " + psqlHost + " | User: " + psqlUser + " | Database: " + psqlDb);

const { Pool } = require('pg');
const pool = new Pool({
    host: psqlHost,
    user: psqlUser,
    password: psqlPass,
    database: psqlDb,
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
});

async function getDbConnection() {
    return await pool.connect();
}

async function getData(query, connection, values = [], explain = false) {
    if (explain) {
        query = `EXPLAIN ANALYZE ${query}`;
    }
    try {
        const res = await connection.query(query, values); // Pass values to the query
        if (explain) {
            console.log("EXPLAIN Output:", res.rows);
        }
        return res.rows; // Return fetched data
    } catch (error) {
        console.error("Database Query Error:", error);
        return null;
    }
}

async function filterAdData(params, connection) {
    let results = null;
    try {
        const ageRanges = Array.isArray(params['ageRanges[]']) ? params['ageRanges[]'] : (params['ageRanges[]'] ? [params['ageRanges[]']] : []);
        const genders = Array.isArray(params['genders[]']) ? params['genders[]'] : (params['genders[]'] ? [params['genders[]']] : []);
        const regions = Array.isArray(params['regions[]']) ? params['regions[]'] : (params['regions[]'] ? [params['regions[]']] : []);

        const startdate = params.startDay ? `${convertDateFormat(params.startDay)} 00:00` : null;
        const enddate = params.endDay ? `${convertDateFormat(params.endDay)} 23:59` : null;
        const platforms = params.platforms;

        let paramIndex = 1;
        let values = [];

        let dateConditions = [];
        if (startdate || enddate) {
            if (params.startedDuring === "true") {
                dateConditions.push(`ad_delivery_start_time >= $${paramIndex++}`);
                dateConditions.push(`ad_delivery_start_time <= $${paramIndex++}`);
            } else {
                dateConditions.push(`ad_delivery_stop_time >= $${paramIndex++}`);
                dateConditions.push(`ad_delivery_start_time <= $${paramIndex++}`);
            }
            values.push(startdate, enddate);
        }
        if (platforms) {
            if (platforms.toLowerCase() === 'facebook') {
                dateConditions.push(`platforms_facebook = true AND platforms_instagram = false`);
            } else if (platforms.toLowerCase() === 'instagram') {
                dateConditions.push(`platforms_instagram = true AND platforms_facebook = false`);
            }
        }
        
        values.push(params.country);
        const dateClause = dateConditions.length ? dateConditions.join(" AND ") : "1=1"; // Fallback to true condition
        const filterClause = `(${dateClause} AND country = $${paramIndex++})`;

        console.log("Starting query for: " + params.filterBy);

        if (params.filterBy === "spending_count") {
            const query = `
            WITH aggregated_data AS (
                SELECT 
                    bylines_name,
                    COUNT(CASE WHEN spend_lower_bound >= 0 AND spend_upper_bound < 100 THEN 1 END) AS count_0_99,
                    COUNT(CASE WHEN spend_lower_bound >= 100 AND spend_upper_bound < 500 THEN 1 END) AS count_100_499,
                    COUNT(CASE WHEN spend_lower_bound >= 500 AND spend_upper_bound < 1000 THEN 1 END) AS count_500_999,
                    COUNT(CASE WHEN spend_lower_bound >= 1000 AND spend_upper_bound < 5000 THEN 1 END) AS count_1000_4999,
                    COUNT(CASE WHEN spend_lower_bound >= 5000 THEN 1 END) AS count_5000_plus,
                    COUNT(*) AS total_ads,
                    SUM(spend_lower_bound) AS sum_spend_lower_bound,
                    SUM(spend_upper_bound) AS sum_spend_upper_bound,
                    SUM(impressions_lower_bound) AS sum_impressions_lower_bound
                FROM ad_data
                WHERE ${filterClause}
                GROUP BY bylines_name
            )
            SELECT 
                bylines_name,
                count_0_99,
                count_100_499,
                count_500_999,
                count_1000_4999,
                count_5000_plus,
                total_ads,
                sum_impressions_lower_bound,
                CASE WHEN sum_impressions_lower_bound > 0 THEN sum_spend_lower_bound::FLOAT / sum_impressions_lower_bound::FLOAT * 1000.0 ELSE 0 END AS spend_lower_per_impression,
                CASE WHEN sum_impressions_lower_bound > 0 THEN sum_spend_upper_bound::FLOAT / sum_impressions_lower_bound::FLOAT * 1000.0 ELSE 0 END AS spend_upper_per_impression,
                CASE WHEN total_ads > 0 THEN sum_spend_lower_bound::FLOAT / total_ads::FLOAT ELSE 0 END AS avg_lower_spend,
                CASE WHEN total_ads > 0 THEN sum_spend_upper_bound::FLOAT / total_ads::FLOAT ELSE 0 END AS avg_upper_spend,
                sum_spend_lower_bound,
                sum_spend_upper_bound
            FROM aggregated_data
            ORDER BY sum_spend_lower_bound DESC;
            `;
            results = await getData(query, connection, values);
        }

        if (params.filterBy === "demographic" || params.filterBy === "all") {
            console.log("Demographic query starts");
            const conditions = [];
            
            let ageRangesString = `1=1`
            if (ageRanges.length) {
                ageRangesString = `(${ageRanges.map(() => `age_range = $${paramIndex++}`).join(" OR ")})`
                conditions.push(ageRangesString);
                values.push(...ageRanges);
            }
            if (genders.length) {
                conditions.push(`(${genders.map(() => `gender = $${paramIndex++}`).join(" OR ")})`);
                values.push(...genders);
            }

            const whereClause = conditions.join(" AND ");
            const query = `
                SELECT
                    bylines_name,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '13-17' AND gender = 'male') AS male_13_17,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '13-17' AND gender = 'female') AS female_13_17,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '18-24' AND gender = 'male') AS male_18_24,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '25-34' AND gender = 'male') AS male_25_34,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '35-44' AND gender = 'male') AS male_35_44,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '45-54' AND gender = 'male') AS male_45_54,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '55-64' AND gender = 'male') AS male_55_64,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '65+' AND gender = 'male') AS male_65_plus,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '18-24' AND gender = 'female') AS female_18_24,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '25-34' AND gender = 'female') AS female_25_34,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '35-44' AND gender = 'female') AS female_35_44,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '45-54' AND gender = 'female') AS female_45_54,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '55-64' AND gender = 'female') AS female_55_64,
                    SUM(age_impressions_lower_bound) FILTER (WHERE age_range = '65+' AND gender = 'female') AS female_65_plus,
                    SUM(age_impressions_lower_bound) FILTER (WHERE (${ageRangesString}) AND (gender = 'unknown') ) AS unknown, 
                    SUM(age_impressions_lower_bound) FILTER (WHERE ${whereClause}) AS total,
                    SUM(age_impressions_lower_bound) AS total_overall
                FROM ad_demographic
                WHERE ${filterClause}
                GROUP BY bylines_name
                ORDER BY total DESC;`;

            results = await getData(query, connection, values);
            console.log("Demographic query ends");
        }

        if (params.filterBy === "region" || params.filterBy === "all") {
            console.log("Region query starts");

            const regionSelectList = regions.map(region => {
            const columnName = region.toLowerCase().replace(/[^a-z0-9]/g, "_");
            values.push(region);
            return `SUM(region_impressions_lower_bound) FILTER (WHERE region = $${paramIndex++}) AS ${columnName}`;
            }).join(",\n");

            const whereClause = regions.map(region => {
            values.push(region);
            return `region = $${paramIndex++}`;
            }).join(" OR ");

            const query = `
            SELECT
            bylines_name,
            ${regionSelectList},
            SUM(region_impressions_lower_bound) FILTER (WHERE ${whereClause}) AS total,
            SUM(region_impressions_lower_bound) AS total_overall
            FROM ad_region
            WHERE ${filterClause}
            GROUP BY bylines_name
            ORDER BY total_overall DESC;`;

            results = await getData(query, connection, values);
            console.log("Region query ends");
        }

        console.log("Query for " + params.filterBy + " done");
        return results;
    } catch (error) {
        console.log("ERROR " + params.filterBy + " query", error);
    }
}

function buildWhereClause(params, table="ad_data") {
    const startdate = params.startDay ? `${convertDateFormat(params.startDay)} 00:00` : null;
    const enddate = params.endDay ? `${convertDateFormat(params.endDay)} 23:59` : null;

    // Define filters with defaults
    const platforms = params.platforms;
    const bylines = params.bylines;

    let dateConditions = [];
    if (startdate || enddate) {
        if (params.startedDuring === "true") {
            if (startdate) dateConditions.push(`${table}.ad_delivery_start_time >= $1`);
            if (enddate) dateConditions.push(`${table}.ad_delivery_start_time <= $2`);
        } else {
            if (enddate) dateConditions.push(`${table}.ad_delivery_start_time <= $2`);
            if (startdate) dateConditions.push(`${table}.ad_delivery_stop_time >= $1`);
        }
    }
    if (platforms) {
        if (platforms.toLowerCase() === 'facebook') {
            dateConditions.push(`${table}.platforms_facebook = true AND ${table}.platforms_instagram = false`);
        } else if (platforms.toLowerCase() === 'instagram') {
            dateConditions.push(`${table}.platforms_instagram = true AND ${table}.platforms_facebook = false`);
        }
    }
    if (bylines) {
        dateConditions.push(`${table}.bylines_name = $3`);
    }
    const dateClause = dateConditions.length ? dateConditions.join(" AND ") : "1=1"; // Fallback to true condition
    return dateClause;
}

async function getFunderPages(params, connection) {
    let whereClause = buildWhereClause(params);
    let verifiedCountry = params.country.slice(0, 2);
    const query = `
    SELECT 
        page_name,
        page_id,
        SUM(impressions_lower_bound) AS impressions_lower_bound,
        SUM(impressions_upper_bound) AS impressions_upper_bound,
        SUM(spend_lower_bound) AS spend_lower_bound,
        SUM(spend_upper_bound) AS spend_upper_bound,
        COUNT(*) AS page_ad_count
    FROM ad_data_${verifiedCountry} ad_data
    WHERE ${whereClause}
    GROUP BY page_id, page_name
    ORDER BY page_ad_count DESC;
    `;
    const result = await getData(query, connection, [params.startDay, params.endDay, params.bylines]);

    return result;
}
async function getFunderAds(params, connection) {
    let whereClause = buildWhereClause(params);
    let verifiedCountry = params.country.slice(0, 2);

    const query = `
    SELECT 
        page_name AS page_name,
        page_id AS page_id,
        ad_data.id AS ad_id,
        impressions_lower_bound,
        impressions_upper_bound,
        spend_lower_bound,
        spend_upper_bound,
        ad_delivery_start_time as delivery_start_time,
        ad_delivery_stop_time as delivery_stop_time,
        latest_collected as latest_collected
    FROM ad_data_${verifiedCountry} ad_data
    WHERE ${whereClause}
    `;
    const result = await getData(query, connection, [params.startDay, params.endDay, params.bylines]);

    return result;
}

async function getFunderMap(params, connection) {
    let whereClause = buildWhereClause(params, "ad_region");
    let verifiedCountry = params.country.slice(0, 2);
    let partitionClause, groupByClause = [];
    let values = [params.startDay, params.endDay, params.bylines]

    if (params.page_id) {
        whereClause = `${whereClause} AND ad_region.page_id = $4`;
        values.push(params.page_id);
        partitionClause = "ad_region.page_id";
        groupByClause = "ad_region.region, ad_region.bylines_name, ad_region.page_id";
    } else {
        partitionClause = "ad_region.bylines_name";
        groupByClause = "ad_region.region, ad_region.bylines_name";
    }


    const query = `
    SELECT
        name,
        CASE WHEN total_impressions > 0 THEN region_impressions_lower_bound / total_impressions ELSE 0 END AS value,
        region_spend_lower_bound AS "minSpend",
        region_spend_upper_bound AS "maxSpend"
    FROM (
        SELECT 
            bylines_name,
            region AS name,
            SUM(region_impressions_lower_bound) AS region_impressions_lower_bound,
            SUM(region_spend_lower_bound) AS region_spend_lower_bound,
            SUM(region_spend_upper_bound) AS region_spend_upper_bound,
            SUM(SUM(region_impressions_lower_bound)) OVER (PARTITION BY ${partitionClause}) AS total_impressions
        FROM ad_region_${verifiedCountry} ad_region
        WHERE ${whereClause}
        GROUP BY ${groupByClause}
    ) subquery
    `;
    var result = await getData(query, connection, values);
    result = result.filter(entry => entry.value !== '0');
    if (result.length === 0) {
        return [];
    }
    var skip = false;
    for (const subRegion of countryStates[params.country].keys()) {
        skip = false;
        for (const row of result) {
            if (row.name === subRegion) {
                row.stateId = countryStates[params.country].get(row.name);
                skip = true;
                continue;
            }
        }
        if (!skip) {
            result.push({
                name: subRegion,
                value: 0,
                minSpend: 0,
                maxSpend: 0,
                stateId: countryStates[params.country].get(subRegion),
            });
        }
    }

    return result;
}

async function getFunderDemographics(params, connection) {
    let whereClause = buildWhereClause(params, "ad_data");
    let values = [params.startDay, params.endDay, params.bylines]
    let verifiedCountry = params.country.slice(0, 2);

    if (params.page_id) {
        whereClause = `${whereClause} AND ad_data.page_id = $4`;
        values.push(params.page_id);
        partitionClause = "ad_data.page_id";
        groupByClause = "ad_data.page_id";
    } else {
        partitionClause = "ad_data.bylines_name";
        groupByClause = "ad_data.bylines_name";
    }

    const query = `
        SELECT 
            ad_data.id AS ad,
            ad_data.page_id AS page_id,
            ad_demographic.gender AS gender,
            ad_demographic.age_range AS age_range,
            ad_demographic.age_percent as percentage,
            ad_data.impressions_lower_bound AS impressions_lower_bound,
            ad_data.impressions_upper_bound AS impressions_upper_bound,
            ad_data.spend_lower_bound AS spend_lower_bound,
            ad_data.spend_upper_bound AS spend_upper_bound
        FROM ad_data_${verifiedCountry} ad_data
        INNER JOIN ad_demographic_${verifiedCountry} ad_demographic ON ad_data.id = ad_demographic.id
        WHERE ${whereClause}
    `;
    const result = await getData(query, connection, values);

    return result;
}

function filterText(text) {
    if (text !== null) {
        // Remove links
        let shortenedBody = text.replace(/https?:\/\/\S+/g, "").replace(/\n/g, " ");
        const words = shortenedBody.split(/\s+/);
        if (words.length > 50) {
            shortenedBody = words.slice(0, 50).join(" ");
        }
        return shortenedBody;
    }
    return text;
}

async function getFunderFrequency(params, connection) {
    let verifiedCountry = params.country.slice(0, 2);
    let whereClause = buildWhereClause(params, "ad_creative_content");
    let values = [params.startDay, params.endDay, params.bylines]


    const query = `
        SELECT 
            bylines_name AS funder,
            ad_creative_content.body AS ad_content,
            COUNT(*) AS ad_count,
            MIN(ad_snapshot_url) AS ad_url
        FROM ad_creative_content_${verifiedCountry} ad_creative_content
        WHERE ${whereClause} AND ad_creative_content.content_order = 1
        GROUP BY bylines_name, ad_creative_content.body
        ORDER BY ad_count DESC
        LIMIT 50;
    `;


    const result = await getData(query, connection, values);

    for (const row of result) {
        row.ad_content = filterText(row.ad_content); // Filter the text
    }

    return result;
}

// Wordcloud freqeuncy calculation pipeline starts here
const natural = require("natural");

// Function to tokenize, remove stopwords
async function tokenizeAndFilter(text) {
    if (text === null) {
        return [];
    }

    // Regex to split on whitespace or emojis
    const splitRegex = /([\p{Emoji_Presentation}\p{Emoji}\u200d]+|\s+)/gu;

    // Split text into tokens, keeping only non-empty, non-whitespace, non-emoji tokens
    const tokens = text
        .split(splitRegex)
        .map(t => t.trim())
        .filter(t => t.length > 0 && !/^[\p{Emoji_Presentation}\p{Emoji}\u200d]+$/gu.test(t));
    return tokens;
}

// Step 1: Compute Term Frequency (TF)
async function computeTF(docs) {
    let tfArray = [];

    for (const doc of docs) {
        if (doc !== null || doc !== "null") {
            let tfMap = {};
            let words = await tokenizeAndFilter(doc);

            words.forEach(word => {
                tfMap[word] = (tfMap[word] || 0) + 1;
            });

            tfArray.push(tfMap);
        }
    }

    return tfArray;
}

// Step 2: Compute Inverse Document Frequency (IDF)
async function computeIDF(tfArray) {
    let idfMap = {};
    let totalDocs = tfArray.length;

    tfArray.forEach(tfMap => {
        Object.keys(tfMap).forEach(word => {
            if (!idfMap[word]) idfMap[word] = 0;
            idfMap[word] += 1;
        });
    });

    Object.keys(idfMap).forEach(word => {
        idfMap[word] = Math.log(totalDocs / (idfMap[word] + 1)); // +1 to avoid div by zero
    });

    return idfMap;
}

// Step 3: Compute TF-IDF for Each Word
async function computeTFIDF(tfArray, idfMap) {
    return tfArray.map(tfMap => {
        let tfidfMap = {};
        Object.keys(tfMap).forEach(word => {
            tfidfMap[word] = tfMap[word] * idfMap[word]; // TF * IDF
        });
        return tfidfMap;
    });
}

// Step 4: Generate N-Gram Scores by Multiplying Word TF-IDF Scores
async function getWeightedNGramScores(doc, tfidfMap, n) {
    if (doc === null) {
        return {}; // Return an empty object if doc is null
    }
    const sentences = doc
        .split(/(?:\r\n|\r|\n|[.,:?!;]|\s{2,})/)
        .map(sentence => sentence.trim());
    const ngramScores = {};

    for (const sentence of sentences) {
        const words = await tokenizeAndFilter(sentence);
        if (words.length < n) continue; // Skip if not enough words for an n-gram

        const NGrams = natural.NGrams.ngrams(words, n);

        NGrams.forEach(ngram => {
            let score = ngram.reduce((acc, word) => {
                const tfidfScore = tfidfMap[word] || 1;
                const sigmoidScore = 1 / (1 + Math.exp(-tfidfScore));
                return acc * sigmoidScore;
            }, 1);

            const phrase = ngram.join(" ");
            ngramScores[phrase] = score * n;
        });
    }

    return ngramScores;
}

function cosineSimilarity(ngram1, ngram2) {
    const set1 = new Set(ngram1);
    const set2 = new Set(ngram2);

    const intersection = [...set1].filter(x => set2.has(x)).length;
    const magnitude1 = Math.sqrt(set1.size);
    const magnitude2 = Math.sqrt(set2.size);

    return intersection / (magnitude1 * magnitude2);
}


async function mergeSimilarNGrams(ngramsWithScores, similarityThreshold = 0.4) {
    const sortedNGrams = Object.entries(ngramsWithScores)
        .sort((a, b) => b[1] - a[1])
        .map(entry => ({ ngram: entry[0], score: entry[1] }));
    const mergedNGrams = [];

    while (sortedNGrams.length > 0) {
        const current = sortedNGrams.shift();
        let similarNGrams = [current]; 

        // Compare it with other ngrams and merge if similarity > threshold
        for (let i = 0; i < sortedNGrams.length; i++) {
            const comparison = sortedNGrams[i];
            const similarity = cosineSimilarity(current.ngram.split(' '), comparison.ngram.split(' '));
            if (similarity >= similarityThreshold) {
                similarNGrams.push(comparison);
                sortedNGrams.splice(i, 1); 
                i--; 
            }
        }
        const bestNGram = similarNGrams.reduce((best, ngram) => (ngram.score > best.score ? ngram : best));

        mergedNGrams.push(bestNGram.ngram);
    }

    return mergedNGrams;
}

async function mergeAndSumSimilarNGrams(ngramsWithScores, similarityThreshold = 0.4) {
    const sortedNGrams = Object.entries(ngramsWithScores)
        .sort((a, b) => b[1] - a[1])
        .map(entry => ({ ngram: entry[0], score: entry[1] }));
    const mergedNGrams = []; 

    while (sortedNGrams.length > 0) {
        const current = sortedNGrams.shift(); 
        let totalScore = current.score; 

        // Compare it with other ngrams and merge if similarity > threshold
        for (let i = 0; i < sortedNGrams.length; i++) {
            const comparison = sortedNGrams[i];
            const similarity = cosineSimilarity(current.ngram.split(' '), comparison.ngram.split(' '));
            if (similarity >= similarityThreshold) {
                totalScore += comparison.score; 
                sortedNGrams.splice(i, 1);
                i--; 
            }
        }

        mergedNGrams.push({"text": current.ngram, "size": totalScore});
    }

    return mergedNGrams;
}

async function getWordCloud(params, connection) {
    var data = await getFunderFrequency(params, connection);

    const adContents = data.map(item => item.ad_content);
    const adFreq = data.map(item => parseInt(item.ad_count));

    let tf = await computeTF(adContents);
    let idf = await computeIDF(tf);
    let tfidf = await computeTFIDF(tf, idf);

    var ngramResults2 = await Promise.all(adContents.map((doc, i) => getWeightedNGramScores(doc, tfidf[i], 2)));
    var ngramResults3 = await Promise.all(adContents.map((doc, i) => getWeightedNGramScores(doc, tfidf[i], 3)));
    var mergedResults2 = await Promise.all(ngramResults2.map(ngram => mergeSimilarNGrams(ngram)));
    var mergedResults3 = await Promise.all(ngramResults3.map(ngram => mergeSimilarNGrams(ngram)));

    var keyword_freq = {};
    mergedResults2.forEach((keywords_list, index) => {
        keywords_list.forEach(keyword => {
            if (keyword_freq[keyword]) {
                keyword_freq[keyword] += adFreq[index];
            } else {
                keyword_freq[keyword] = adFreq[index];
            }
        });
    });

    mergedResults3.forEach((keywords_list, index) => {
        keywords_list.forEach(keyword => {
            if (keyword_freq[keyword]) {
                keyword_freq[keyword] += Math.round(adFreq[index] * 1.2);
            } else {
                keyword_freq[keyword] = Math.round(adFreq[index] * 1.2);
            }
        });
    });
    var result = await mergeAndSumSimilarNGrams(keyword_freq);
    result.sort((a, b) => b.size - a.size);
    return result.slice(0, 50);
}


