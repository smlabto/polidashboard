var express = require('express')
var router = express.Router()
var mongoose = require('mongoose')
const fs = require('fs');
var _ = require('underscore');
var countries = require('./countries.json');
var countryStates = require('./country_states.js');
const https = require("http") //https
const path = require('path');

var db = mongoose.connection.db

router.get('/', function(req, res) {
    res.redirect('/facebook_ads_v2?country=ca')
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

  console.log(countryCurrencyMap); // Output for testing
} catch (err) {
  console.error('Error reading the JSON file:', err);
}

// countryCurrencyMap is now accessible globally
module.exports = countryCurrencyMap;

router.get('/facebook_ads_v2', function (req, res) {
    var start = parseInt(req.query.startDay)
    var end = parseInt(req.query.endDay)

    if (isNaN(start)) start = 7;
    if (isNaN(end)) end = 0;

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
            validCountries: validCountries,
            regions: regions,
            fs: fs,
            firstDay: firstDay,
            currency: currency,
            currencySymbol: currencySymbol
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

router.post('/status/country', function(req, res) {
    var country = req.body.country
    //console.log(country)
    if (!countries.some(c=> {return c.code==country})){
        res.send(null)
        return
    }
    db.collection('facebook_ads_' + country).aggregate([
        {
            '$sort': {
                'latest_collected': -1
            }
        }, {
            '$limit': 1
        }
    ]).toArray((err, data) => {        
        try {
            var timestamp = data[0].latest_collected

            db.collection('facebook_ads_' + country).countDocuments().then(n => {
                res.send({
                    timestamp: timestamp,
                    total_ads: n
                })
            })
        } catch(e) {
            console.log(e);
            // [Error: Uh oh!]
        }
    })
})

router.post('/facebook_ads_v2/heatmap', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var country = req.body.country
    //console.log(country)
    generateHeatmap(start, end, country, res)
});

router.post('/facebook_ads_v2/funder_pages', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    if (funder == '') funder = null;
    //console.log('/facebook_ads_v2/funder_pages')
    generateFunderPages(start, end, funder, country, res)
});

router.post('/facebook_ads_v2/funder_demographics', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    if (funder == '') funder = null;
    generateFunderDemographics(start, end, funder, country, res)
});

router.post('/facebook_ads_v2/funder_timeline', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    if (funder == '') funder = null;
    generateFunderTimeline(start, end, funder, country, res)
});

router.post('/facebook_ads_v2/funder_map', (req, res) => {
    console.log("RECEIVED MAP REQUEST")
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    var page_id = req.body.page_id
    if (page_id == '') page_id = null;
    if (funder == '') funder = null;
    // console.log(req.body)
    generateFunderMap(start, end, funder, country, page_id, res)
});

router.post('/facebook_ads_v2/frequency_table', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    var page_id = req.body.page_id
    if (page_id == '') page_id = null;
    if (funder == '') funder = null;
    generateFreqTable(start, end, funder, country, page_id, res);
});

router.post('/facebook_ads_v2/funder_word', (req, res) => {
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    var page_id = req.body.page_id
    var is_wordcloud = req.body.is_wordcloud
    if (funder == '') funder = null;
    generateWordMap(start, end, funder, country, is_wordcloud, page_id, res);
});

module.exports = router

var heatmapData = {};

function generateHeatmap(start, end, country, res=null) {
    console.log('Generating Heatmap')
    var query = [
        {
            '$match': quickDateFilter(start, end), 
        }, {
            '$match': {'currency': countryCurrencyMap[country]}, 
        }, {
            '$group': {
            '_id': {
                'funding_entity': '$funding_entity', 
                'spend': '$spend'
            }, 
            'count': {
                '$sum': 1
            }
            }
        }, {
            '$group': {
            '_id': '$_id.funding_entity', 
            'spends': {
                '$push': {
                    'spend': '$_id.spend', 
                    'count': '$count'
                }
            }, 
            'total': {
                '$sum': '$count'
            }
            }
        }, {
            '$sort': {
                'total': -1
            }
        }, {
            '$project': {
                'funding_entity': '$_id', 
                '_id': 0, 
                'spends': 1, 
                'total': 1
            }
        }
    ]

    var heatmapCode = heatmapKey(start, end, country);
    var oldestDate = new Date();

    oldestDate.setHours(oldestDate.getHours() - 12)

    if (
        heatmapCode in heatmapData 
        && heatmapData[heatmapCode]['timestamp'] > oldestDate
        && res !== null
    ) {
        res.send(heatmapData[heatmapCode]['data'])
    } else {
        db.collection('facebook_ads_' + country)
            .aggregate(query)
            .toArray((err, data) => {
                // console.log(country)
                heatmapData[heatmapCode] = {
                    data: data,
                    timestamp: Date.now()
                }
                if (res !== null) {
                    res.send(data)
                }
            })
    }
}

countries.forEach(c => {
    generateHeatmap(0, 7, c.code)
    setInterval(function() {generateHeatmap(0, 7, c.code)}, 1000*60*60*4)
})

function getDateFilter(start, end) {
	// include ad if it was collected at any time during the timeframe
	var lessThan = new Date( new Date() - end*60*60*24*1000)
	lessThan.setHours( 23, 59, 59)
    console.log('Less than:')
    console.log(lessThan)
	var greaterThan = new Date( new Date() - start*60*60*24*1000)
	greaterThan.setHours( 0, 0, 0)
    console.log('Greater than:')
    console.log(greaterThan)
	
	return {
		'_id.timestamp': {
			$gte: greaterThan,
			$lte: lessThan,
		}
	}
}

function quickDateFilter(start, end) {
    var endTime = new Date( new Date() - end*60*60*24*1000)
    var startTime = new Date( new Date() - start*60*60*24*1000)

    return {
        '$and': [
            {
                '$or': [
                    {
                        'delivery_start_time': {
                            '$gte': startTime
                        }
                    },
                    {
                        'first_collected': {
                            '$gte': startTime
                        }
                    }
                ]
            }, {
                '$or': [
                    {
                        'delivery_start_time': {
                            '$lte': endTime
                        }
                    },
                    {
                        'delivery_stop_time': {
                            '$lte': endTime
                        }
                    },
                    {
                        'latest_collected': {
                            '$lte': endTime
                        }
                    }
                ]
            }
        ]
    }
}

function generateFunderPages(start, end, funder, country, res=null) {
    console.log("Generating funder pages: " + country);
    var query = [
        {
          '$match': quickDateFilter(start, end)
        }, {
            '$match': {'currency': countryCurrencyMap[country]}, 
        }, {
          '$match': {
            'funding_entity': funder
          }
        }, {
          '$group': {
            '_id': '$page_id', 
            'spend_lower_bound': {
              '$sum': '$spend.lower_bound'
            }, 
            'spend_upper_bound': {
              '$sum': '$spend.upper_bound'
            }, 
            'impressions_lower_bound': {
              '$sum': '$impressions.lower_bound'
            }, 
            'impressions_upper_bound': {
              '$sum': '$impressions.upper_bound'
            }, 
            'total_ads': {
              '$sum': 1
            }
          }
        }, {
          '$sort': {
            'total_ads': -1
          }
        }, {
          '$lookup': {
            'from': 'facebook_pages_' + country, 
            'localField': '_id', 
            'foreignField': '_id', 
            'as': 'page_info'
          }
        }, {
          '$project': {
            'page_id': '$_id', 
            'spend': {
              'lower_bound': '$spend_lower_bound', 
              'upper_bound': '$spend_upper_bound'
            }, 
            'impressions': {
              'lower_bound': '$impressions_lower_bound', 
              'upper_bound': '$impressions_upper_bound'
            }, 
            'page_name': {
              '$arrayElemAt': [
                '$page_info.name', 0
              ]
            }, 
            'total_ads': 1, 
            '_id': 1
          }
        }
      ]

    db.collection('facebook_ads_' + country)
            .aggregate(query)
            .toArray((err, data) => {
                if (res !== null) {
                    res.send(data)
                }
            })
}

function generateFunderDemographics(start, end, funder, country, res=null) {
    console.log("Generating funder demographics: " + country);
    const query = [
        {
            '$match': {
                '$and': [
                    quickDateFilter(start, end),
                    { 'funding_entity': funder }
                ]
            }
        },
        {
            '$match': {'currency': countryCurrencyMap[country]}, 
        },
        {
            '$lookup': {
                'from': 'facebook_demographics_' + country,
                'localField': '_id',
                'foreignField': '_id',
                'as': 'demographics'
            }
        },
    ]
    if (country != 'us') {
        query.push(
            {
                '$lookup': {
                    'from': 'facebook_regions_' + country,
                    'localField': '_id',
                    'foreignField': '_id.ad',
                    'as': 'regions'
                }
            },
            {
                '$project': {
                    'spend': 1,
                    'impressions': 1,
                    'demographics': { $ifNull: [ "$demographics", [] ] },
                    'regions': 1, 
                    'snapshot_url': 1,
                    'titles': '$creative_link_titles',
                    'page_id': 1
                }
            }
        )
    } else {
        query.push(
            {
                '$project': {
                    'spend': 1,
                    'impressions': 1,
                    'demographics': { $ifNull: [ "$demographics", [] ] },
                    'snapshot_url': 1,
                    'titles': '$creative_link_titles',
                    'page_id': 1
                }
            }
        )
    }
    
    db.collection('facebook_ads_' + country)
            .aggregate(query)
            
            .toArray((err, data) => {
                if (res !== null) {
                    res.send(data)
                }       
            })
}

function generateFunderTimeline(start, end, funder, country, res) {
    console.log("Generating funder timeline: " + country);
    var query = [
        {
            '$match': quickDateFilter(start, end)
        }, {
            '$match': {'currency': countryCurrencyMap[country]}, 
        }, {
            '$match': {
                'funding_entity': funder
            }
        }, {
            '$project': {
                'spend': 1, 
                'first_collected': '$delivery_start_time', 
                'latest_collected': 1,
                'page_id': 1
            }
        }
    ]

    var cursor = db.collection('facebook_ads_' + country)
            .aggregate(query, {allowDiskUse: true})
    cursor.toArray((err, data) => {
                if (res !== null) {
                    res.send(data)
                }
            })
}

async function generateFunderMap(start, end, funder, country, page_id, res) {
    console.log("Generating funder map: " + country);
    if (funder === "No funding entity given") {
        funder = null;
    }
    var query = [
        {
            '$match': {
                ...quickDateFilter(start, end),
                'funding_entity': funder,
                'delivery_by_region': { '$ne': null }
            }
        },
        {
            '$match': {'currency': countryCurrencyMap[country]}, 
        },
        {
            '$project': {
                'spend': 1,
                'delivery_by_region': 1
            }
        }
    ];

    if (page_id != null) {
        query = [
            {
                '$match': {
                    ...quickDateFilter(start, end),
                    'funding_entity': funder,
                    'page_id': page_id
                }
            },
            {
                '$match': {'currency': countryCurrencyMap[country]}, 
            },
            {
                '$project': {
                    'spend': 1,
                    'delivery_by_region': 1
                }
            }
        ];
    }

    const stateCodeDictionary = countryStates[country];
    
    const cursor = db.collection('facebook_ads_' + country)
        .aggregate(query, { allowDiskUse: true });

    const stateTotals = new Map();
    const minSpend = new Map();
    const maxSpend = new Map();
    let totalCount = 0;

    const documents = await cursor.toArray();

    for (const stateName of stateCodeDictionary.keys()) {
        // Initialize the stateTotal for the current stateName
        stateTotals.set(stateName, 0);
        minSpend.set(stateName, 0);
        maxSpend.set(stateName, 0);
    }

    documents.forEach(doc => {
        const deliveryByRegion = doc.delivery_by_region;
        const spendingByAd = doc.spend;
        const spendLowerBound = spendingByAd.lower_bound;
        const spendUpperBound = spendingByAd.upper_bound;

        let stateId = "Unknown"
        let deliveryAmount = 1.0;

        if (deliveryByRegion !== null) {
            totalCount++;
            for (const state in deliveryByRegion) {
                const stateName = state;
                deliveryAmount = deliveryByRegion[state];

                stateId = stateName;

                if (!stateTotals.has(stateId)) { // If it is a region that isn't one of the defined countries regions, set it to "Unknown"
                    stateId = "Unknown";
                }

                if (stateTotals.has(stateId)) {
                    stateTotals.set(stateId, stateTotals.get(stateId) + deliveryAmount);
                } else {
                    stateTotals.set(stateId, deliveryAmount);
                }

                if (spendLowerBound > 0) { // it's possible for this to be 0
                    let adLowerBoundFactoredByState = spendLowerBound * deliveryAmount;
                    minSpend.set(stateId, minSpend.get(stateId) + adLowerBoundFactoredByState);
                }
                let adUpperBoundFactoredByState = spendUpperBound * deliveryAmount;
                maxSpend.set(stateId, maxSpend.get(stateId) + adUpperBoundFactoredByState)
            }
        }
    });

    stateTotals.forEach((value, stateName) => {
        stateTotals.set(stateName, value / totalCount);
    });

    if (res !== null) {
        const stateTotalsArray = Array.from(stateTotals, ([name, value]) => ({ name, value }));
        const stateTotalsArrayWithNames = stateTotalsArray.map(obj => {
            const stateId = stateCodeDictionary.get(obj['name']);
            const minSpendValue = minSpend.get(obj['name']);
            const maxSpendValue = maxSpend.get(obj['name']);
            return {
                name: obj['name'],
                stateId: stateId,
                value: obj['value'],
                minSpend: minSpendValue,
                maxSpend: maxSpendValue
            };
        });
        res.json(stateTotalsArrayWithNames);
    }
}

// --- Helper functions for frequency summary table ---
// ####################################################
async function fetchPage(db, country, page_id) {
    const pagesCollection = db.collection(`facebook_pages_${country}`);
    const page = pagesCollection.findOne({ _id: page_id });
    return page;
}

async function fetchAds(db, country, funding_entity, page_id, start, end) {
    const adsCollection = db.collection(`facebook_ads_${country}`);

    let query = [
        {
            '$match': {
                ...quickDateFilter(start, end),
            }
        }, {
            '$match': {'currency': countryCurrencyMap[country]}, 
        }, {
            '$match': {
              'funding_entity': funding_entity
            }
        },
    ];

    if (funding_entity !== null) {
        query[0].$match.funding_entity = funding_entity;
    }

    if (page_id !== null) {
        query[0].$match.page_id = page_id;
    }

    const cursor = adsCollection.aggregate(query, { allowDiskUse: true });

    const ads = await cursor.toArray();

    // Convert to a list of dictionaries
    const mergedAds = mergeMultipleCreativeBodies(ads);
    return mergedAds;
}

function mergePageNameWithAssociatedAds(ads, pageName) {
    for (const ad of ads) {
        ad.page_name = pageName;
    }
    return ads;
}

async function mergeMultipleCreativeBodies(ads) {
    for (const ad of ads) {
        let creativeBodiesCombined = "";

        try {
            for (const creativeBody of ad.creative_bodies) {
                if (creativeBodiesCombined === "") {
                    creativeBodiesCombined = creativeBody;
                    console.log(creativeBody);
                }
            }
            ad.creative_bodies = creativeBodiesCombined;
        } catch (error) {
            ad.creative_bodies = "";
        }
    }
    return ads;
}

function createAdsSummaryTable(ads, country, maxTableLength = 100) {
    const adsSummaryTable = [];
    
    for (const ad of ads) {
        let foundPreviousAd = false;

        for (const uniqueAd of adsSummaryTable) {
            if (ad.creative_bodies === uniqueAd.creative_bodies) {
                foundPreviousAd = true;
                uniqueAd.freq += 1;
                uniqueAd.ad_ids.push(ad._id);
                break;
            }
        }

        function removeEmojis(input) {
            // Define a regular expression to match emojis and special characters
            return input;
            const emojiRegex = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g;
            
            // Remove emojis and special characters
            const cleanedInput = input.replace(emojiRegex, '');
          
            return cleanedInput;
        }

        if (!foundPreviousAd) {
            country = country.toUpperCase();
            
            let shortenedBody = ad.creative_bodies;
            let adId = ad._id;
            console.log(adId)
            shortenedBody = shortenedBody.replace(/\n/g, ' ');
            const words = shortenedBody.split(/\s+/);
            
            if (words.length > 50) {
                shortenedBody = words.slice(0, 50).join(" ");
            }

            const creativeBodyEncoded = encodeURIComponent(removeEmojis(shortenedBody).replace(/['"“”]/g, ""));

            shortenedBody = shortenedBody.replace(/#/g, ''); // Remove hashtags, it breaks the URL search

            console.log(creativeBodyEncoded)

            // const snapshotUrl = `https://www.facebook.com/ads/library/?active_status=all&ad_type=political_and_issue_ads&country=${country}&q=${shortenedBody}&media_type=all`;
            const snapshotUrl = `https://www.facebook.com/ads/library/?id=${adId}`                

            adsSummaryTable.push({
                creative_bodies: ad.creative_bodies,
                freq: 1,
                ad_ids: [ad._id],
                funding_entity: ad.funding_entity,
                snapshot_url: snapshotUrl,
            });
        }
    }

    adsSummaryTable.sort((a, b) => b.freq - a.freq);

    if (adsSummaryTable.length > maxTableLength) {
        adsSummaryTable.splice(maxTableLength);
    }

    return adsSummaryTable;
}

async function generateFreqTable(start, end, funder, country, page_id = null, res) {
    console.log("Generating frequency table: " + country);

    // Only add the page name to the ads if pageId is provided
    let pageName = '';
    if (page_id !== null) {
        const page = await fetchPage(db, country, page_id);
        if (page !== null) {
            pageName = page.name;
        } else {
            return { error: "An error occurred", data: null };
        }
    }

    let ads = await fetchAds(db, country, funder, page_id, start, end);

    if (page_id !== null) {
        ads = mergePageNameWithAssociatedAds(ads, pageName);
    }

    const adsSummary = createAdsSummaryTable(ads, country);
    const resultDict = { summary_table: adsSummary };
    return res.json(resultDict);
}

async function generateWordMap(start, end, funder, country, is_wordcloud = false, page_id = null, res) {
    const apiUrl = process.env.WORDCLOUD_API_URL;

    // Replace with the appropriate query parameters
    // Currently using temporary parameters
    const _country = country;
    const start_time = new Date( new Date() - start*60*60*24*1000)
    const end_time = new Date( new Date() - end*60*60*24*1000)
    
    const queryParams = new URLSearchParams();
    if (page_id != null) {
        queryParams.append("page_id", page_id.toString());   
    } else {
        queryParams.append("funding_entity", funder);
    }
    queryParams.append("country", _country);
    queryParams.append("start_time", start_time.toISOString());
    queryParams.append("end_time", end_time.toISOString());
    
    const fullUrl = apiUrl + "?" + queryParams.toString();
    
    try {
        // Parse the URL
        const url = new URL(fullUrl);

        // Create an HTTP request options object
        const options = {
            method: 'GET',
            hostname: url.hostname,
            port: url.port,
            path: url.pathname + url.search,
        };

        // Make the HTTP GET request
        const request = https.request(options, (response) => {
            let data = '';

            // Listen for data events and accumulate the response data
            response.on('data', (chunk) => {
                data += chunk;
            });

            response.on('end', () => {
                if (response.statusCode !== 200) {
                    // Check for a 422 status code and handle the response body
                    if (response.statusCode === 422) {
                        try {
                            const responseData = JSON.parse(data);
                            console.error("Validation error:", responseData);
                            return { error: "An error occurred", data: null };
                        } catch (error) {
                            console.error("Error parsing response body:", error);
                            return { error: "An error occurred", data: null };
                        }
                    } else {
                        console.error(`HTTP error! Status: ${response.statusCode}`);
                        return { error: "An error occurred", data: null };
                    }
                } else {
                    const responseData = JSON.parse(JSON.parse(data));
                    res.json(responseData);
                }
            });
        });

        // Handle any errors that occur during the request
        request.on('error', (error) => {
            console.error("Request error:", error);
            res.json({ 'error': "An error occurred" });
        });

        // Send the request
        request.end();
    } catch (error) {
        console.error("URL parsing error:", error);
        res.json({ 'error': "An error occurred" });
    }
}

function heatmapKey(start, end, country) {
    return `${end}-${start}-${country}`
}