var express = require('express')
var router = express.Router()
var mongoose = require('mongoose')
const fs = require('fs');
var _ = require('underscore');
var countries = require('./countries.json');
var countryStates = require('./country_states.js');


var db = mongoose.connection.db

router.get('/', function(req, res) {
    res.redirect('/facebook_ads_v2?country=ca')
})

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

        console.log (data)
        
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
    var start = parseInt(req.body.startDay)
    var end = parseInt(req.body.endDay)
    var funder = req.body.funder
    var country = req.body.country
    if (funder == '') funder = null;
    generateFunderMap(start, end, funder, country, res)
});

module.exports = router

var heatmapData = {};

function generateHeatmap(start, end, country, res=null) {
    console.log('Generating Heatmap')
    var query = [
        {
            '$match': quickDateFilter(start, end), 
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
                console.log(country)
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
                'first_collected': {
                '$lte': endTime
                }
            }, {
                'latest_collected': {
                    '$gte': startTime
                }
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
    var query = [
        {
            '$match': quickDateFilter(start, end)
        }, {
            '$match': {
                'funding_entity': funder
            }
        }, {
            '$lookup': {
                'from': 'facebook_audiences_' + country,
                'localField': '_id',
                'foreignField': '_id.ad',
                'as': 'demographics'
            }
        }, {
          '$lookup': {
            'from': 'facebook_regions_' + country, 
            'localField': '_id', 
            'foreignField': '_id.ad', 
            'as': 'regions'
          }
        }, {
            '$project': {
                'spend': '$spend', 
                'impressions': '$impressions', 
                'demographics': 1, 
                'regions': 1, 
                'snapshot_url': '$snapshot_url', 
                'titles': '$creative_link_titles',
                'page_id': '$page_id'
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

function generateFunderTimeline(start, end, funder, country, res) {
    console.log("Generating funder timeline: " + country);
    var query = [
        {
            '$match': quickDateFilter(start, end)
        }, {
            '$match': {
                'funding_entity': funder
            }
        }, {
            '$project': {
                'spend': 1, 
                'first_collected': 1, 
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

async function generateFunderMap(start, end, funder, country, res) {
    console.log("Generating funder map: " + country);
    const query = [
        {
            '$match': {
                ...quickDateFilter(start, end),
                'funding_entity': funder
            }
        },
        {
            '$project': {
                'spend': 1,
                'delivery_by_region': 1
            }
        }
    ];

    // Eventually don't hardcode this, once more countries are setup
    const stateCodeDictionary = countryStates['us'];
    
    const cursor = db.collection('facebook_ads_' + country)
        .aggregate(query, { allowDiskUse: true });

    const stateTotals = new Map();
    let totalCount = 0;

    const documents = await cursor.toArray();

    for (const stateName of stateCodeDictionary.keys()) {
        // Initialize the stateTotal for the current stateName
        stateTotals.set(stateName, 0);
    }

    documents.forEach(doc => {
        const deliveryByRegion = doc.delivery_by_region;

        if (deliveryByRegion !== null) {
            totalCount++;
            for (const state in deliveryByRegion) {
                // console.log(state);
                const stateName = state;
                const deliveryAmount = deliveryByRegion[state];

                if (stateName) {
                    if (stateTotals.has(stateName)) {
                        stateTotals.set(stateName, stateTotals.get(stateName) + deliveryAmount);
                    } else {
                        stateTotals.set(stateName, deliveryAmount);
                    }
                } else {
                    // If state is not in stateCodeDictionary, place it as "Outside of Country"
                    const unknownStateId = "Outside of Country";
                    if (stateTotals.has(unknownStateId)) {
                        stateTotals.set(unknownStateId, stateTotals.get(unknownStateId) + deliveryAmount);
                    } else {
                        stateTotals.set(unknownStateId, deliveryAmount);
                    }
                }
            }
        }
    });

    stateTotals.forEach((value, stateName) => {
        stateTotals.set(stateName, value / totalCount);
    });

    if (res !== null) {
        const stateTotalsArray = Array.from(stateTotals, ([name, value]) => ({ name, value }));
        const stateTotalsArrayWithNames = stateTotalsArray.map(obj => ({ ...obj,
            stateId: stateCodeDictionary.get(obj['name'])
        }));
        res.json(stateTotalsArrayWithNames);
    }
}

function heatmapKey(start, end, country) {
    return `${end}-${start}-${country}`
}