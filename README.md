<div align="center">
  <a href="#"><img src="https://socialmedialab.ca/wp-content/uploads/2022/05/TMU_TRSM_SocialMediaLab_transparent_WHITE-1.png.webp" height="50px" /></a>
  <h1></h1>
  <a href="https://polidashboard.com/" target="_blank">
    <img src="https://app.polidashboard.org/images/main-logo.png" height="120px" />
  </a>
</div>

## ❔About

PoliDashboard is an app for tracking political advertisements on Meta-owned advertising platforms such as Facebook and Instagram. It is designed to help voters, journalists, campaign staffers and others to track the use of targeted ads around social issues, elections or politics.

The dashboard is developed by the Social Media Lab at Toronto Metropolitan University as part of an international election transparency initiative.

## ❇️ Overview

The dashboard consists of:

1.  A data collector, written in python, which collects ads from the Facebook API | `/collector` 
    
2.  A Node app, which serves the website and handles database queries | `/webapp`
    
3.  A front end, written in vanilla javascript with EJS and D3.js | `/webapp`
    
4.  A FastAPI module that creates a wordcloud based on ads creatives | `/keywords_extractor`

5.  A MongoDB database

## ❇️ Installing and Running the App

Install npm dependencies and run node application:
`npm i` > `node webapp/app.js`

### ➕ Setting up Wordcloud Generator [OPTIONAL]
Run a web server using FastAPI inside of `/keywords_extractor`, to service the wordcloud functionality. Uvicorn has been tested and works (other solutions may work), the command to do so (replacing port_number): 
`cd keywords_extractor` > `python -m uvicorn api_service:app --host 0.0.0.0 --port [port_number]`

Currently the `keywords_extractor` API is being accessed by the `generateWordMap(...)` function inside of `/webapp/facebook_routes.js`.
This function reads WORDCLOUD_API_URL from your environment variables, so make sure to set it.

`export WORDCLOUD_API_URL=0.0.0.0:[port_number]`

## ❇️ Collector

The important part of the collector is in collector/collect.py (the other files in the collector module are provided by Facebook). 
"collect.py" accepts the country code (i.e. ca, us) as an argument, and has a method to update each of the five Mongo collections for each ad.

You can learn more about the fields [Facebooks Ad Library API provides here](https://www.facebook.com/ads/library/api/)

## ❇️ Adding New Countries

### ➕ Data Collector

1.  Follow the instructions inside of the `collector/fb_ads_library_api.py` file, replacing that file with the one provided in the download link
2.  Create a cron job to run the `collect.py` script to collect ads every day. This will automatically generate all of the necessary database collections and indexes the first time it is run.
    `python collector/collect.py [two-letter country code]`

### ➕ Frontend

Add the following relevant data on the new country to `webapp/countries.json`. Adding a country to this file will make it appear as an option in the dropdown on the front page. 
1.  Set `“first date”` to the oldest date (dd-mm-yyyy) for which data is available for the country - this will set the minimum date in the date selector
2.  [UNUSED] Set `“regions”` to contain a mapping of the country’s longform regions/states/provinces to the abbreviations that’ll be shown on the regions chart
3.  Set `“currency”` to a three letter currency code (e.g. “CAD”, “USD”, “EUR”, etc.)
4.  Set `“currency_symbol”` to the symbol used to abbreviate the currency (e.g. “$”, “£”, “€”, etc.)
5.  Set `“name”` and `“code”` to the country’s name and two letter code (lower case)    
6.  If you need a footnote (i.e. the “Partner Institution” box), place it in node/views/partials/footnotes/[country code].ejs - see au.ejs as an example. Whatever you place in this file will automatically be added below the summary tab, and you can put any country-specific CSS in here as well

### ➕ Adding Country Map
PoliDashboard makes use of TopoJSON files to render the map modules. The generation of the map is handled in the `Statemap` class, located at `webapp/views/partials/statemap.ejs`, the TopoJSON data is loaded from `webapp/public/maps/` by the `fetchTopoData()` function. 

The TopoJsons need to be cut up in a way that it matches the states/regions of the data Facebooks API provides us from the `delivery_by_region` field. We primarily get these from [https://code.highcharts.com/mapdata/](https://code.highcharts.com/mapdata/). However, sometimes the data Facebooks API gives us does not match up nicely with the TopoJsons provided by Highcharts (ex. this happened with Spain, as Facebook gave us the `delivery_by_region` data based on Spains autonomous regions, and Highchart did not have a map of Spain cut up by its autonomous regions. So if this happens, you will have to find a map that matches.) The TopoJSON should have a unique id for each region. Polidashboard associates the name of a region (given by facebooks `delivery_by_region` field) with the unique id of that region on the TopoJSON. This association needs to be manually created inside of `webapp/country_states.js` as a Map object of an array of `["Region Name from Facebook", "TopoJson ID"]` pairs for the country you want to add (It is also necessary to add an "Unknown" region, you can see each country has this region, it is for the Learn More section).

> If your TopoJSON does not have an id field for each region, or you can only find a GeoJSON of the country you are trying to add, you can use this tool [https://mapshaper.org/](https://mapshaper.org/). It accepts lots of file formats, including GeoJSON, and it can export into TopoJSON. The main thing you will want to do with this tool is rename the layer (at the top of the page) to `default` (because by default in the code, `topo_data = mapDataset.objects.default;`) and you can also add/modify the ID's of the map regions using the `edit attributes` tool. All you will need to add is an ID field (call the field `FID`, `id` probably works but I never tested it, the maps from Highchart used `FID` for their maps, and d3.js didn't complain, so I kept the same format)

Here is the general order of steps you should follow to add a country map:
1) Find document(s) in your MongoDB that has all, if not most, of the states inside of `delivery_by_region`.
2) Find a TopoJSON that has all of these states (should follow some kind of a government recognized standard that you can just wikipedia, then follow that to help you find a TopoJSON).
2.5 optional) Import the map into this handy tool [https://mapshaper.org/](https://mapshaper.org/) to modify layer name OR add/modify ids. 
3) Add the TopoJson files under the `/public/maps/` directory, (it will automatically be read from the `fetchTopoData()` function)
4) Add the key `["Region Name from Facebook", "TopoJson ID"]` pairs to `webapp/country_states.js` for the country

   *At this point the app should run and you should see the map, if you don't see the map, try to see if it rendered inside of the svg using inspect element, if you see a bunch of <path> objects then it works, you just need to modify the transformations*
   
6) Add to the `transformations` object inside of the `Statemap` class your country, applying the necessary scale + translate (if country is upside down, y-scale needs to be negative)
7 optional) If your country has a very small state that would be difficult to see/hover the mouse over, you can add to the `smallTerritoryBoxes` array an object that represents a box for that region. 

## ❇️ Updating API Keys

The Meta Ad Library API key needs to be updated every two months. To do this, update or get new keys got to GRAPH API explore from [https://developers.facebook.com/tools/explorer/](https://developers.facebook.com/tools/explorer/)
and set it to the environment variable `FACEBOOK_API_KEY` (you may also paste it into `~/facebook_dashboards/collector/collect.py` inside of the `FbAdsLibraryTraversal()` object). You don’t need to restart anything - the new key will be used automatically next time the collector’s CRON job runs.

### ➕ Logging

The collector stores its logs in node/public/logs.txt. This file is publicly accessible through the node app, and is used by the status page to determine the collector’s status. You can set a CRON job to automatically flush the logs to ~/old_logs/ on the first of each month:

> 1 1 1 * * mv /home/ubuntu/facebook_dashboards/node/public/log.txt
> /home/ubuntu/old_logs/logs_$(date "+%Y-%m").txt

## ❇️ Database

For each of the entities below, there is a collection for each country (e.g. facebook_timestamps_ca, facebook_timestamps_us, etc). It’s organized as follows:

1.  **Timestamps** (e.g. facebook_timestamps_ca)
-   The collector queries every active ad each time it runs, and their IDs and timestamps are recorded here
-   One ad has many documents in this collection
-   The delivery start and end times provided by Facebook aren’t necessarily accurate - sometimes ads are temporarily deactivated
-   Any query with a timeframe should check this table
-   Indexes: _id.timestamp, _id.ad
    
2.  **Ads** (e.g. facebook_ads_ca)
-   This contains all the ad-specific metadata provided by Facebook, including funding entity, impressions, spend range, and page ID
-   Each ad has only one document in this collection, which is updated each time it is collected
-   Indexes: _id, funding_entity, first_collected, latest_collected, delivery_start_time
    
3.  **Audiences** (e.g. facebook_audiences_ca) 
-   All of the demographic data is recorded here 
-   There is always one document that correlates to one ad inside of `facebook_ads` collection
-   Consists of an `_id` and an array `audience` of objects, each object in the array consists of an `_id` and a `percentage` field
    -  The `_id` consists of the `ad` id, `age`, and `gender`. It is packed this way because the original demographic chart accepted the data this way. Initially this collection consisted of the documents that now go in this array, however it made the queries to the collection very slow. Now they are wrapped with the ad `_id` and `audience` contains all of the demographic information for that ad. 
-   Indexes: audience._id.ad, audience._id.age, audience._id.gender
    
4.  ~~**Regions** (e.g. facebook_regions_ca)~~ NOT NEEDED AS MAP READS FROM THE FIELD `delivery_by_region` FROM AD DIRECTLY
-   This table stores data on regional impressions in the same structure as the audiences table    
-   There is one document for each region/ad ID combination
-   Indexes: _id.ad
    
5.  **Pages** (e.g. facebook_pages_ca)
-   This table just maps page IDs to their names, so that changes in page names will be reflected across the dashboard
-   Indexes: _id

The indexes are handled automatically by the collector.

## ❇️ Node Application

### ➕ Routes

**/facebook_ads_v2**
   
-   URL Parameters:
	-   startDay - the oldest day to query (default is 7)
	-   endDay - the newest day to query (default is 0)
-   Sends the site template with basic metadata for EJS:
	-   fbStartDay - the oldest day to query 
	-   fbEndDay - the most recent day to query
	-   days - the number of days included
	-   child - the EJS template used to fill the body of the site (this is a legacy from an old version of the dashboard)
	-   country - the currently selected country (default is ‘ca’)
	-   validCountries - a list of all countries to include in the dropdown list (populated by countries.json)
	-   fs - filesystem, used for EJS templating
	-   firstDay - the first day for which there is data available for the country, used to set the minimum date in the date picker
	-   currency (default ‘CAD’)
	-   currencySymbol (default ‘$’)
    

### ➕ Polidashboard API

The node application provides several API endpoints to fill the data on the front-end. Their queries and code can be found in `webapp/facebook_routes.js`. In general, date ranges are represented by integers startDay and endDay, where the days are numbered backwards (today is day 0, yesterday is day 1, etc). The routes are as follows:

**`/status/country`**
 -   URL params: country
	-   Returns the timestamp of the most recent document in that country’s database, and the total number of ads collected for the country to date
    
**`/facebook_ads_v2/heatmap`**
    -   URL params: startDay, endDay
 - Sends the number of ads posted by each funder in each spend range,
   used to fill the heatmap on the left
-   This query is automatically cached every four hours for each country

> The following endpoints below all take in the same base parameters `startDay, endDay, funder, country `

**`/facebook_ads_v2/funder_pages`**
-   Sends data on each of the pages a funding entity as supported, including spend range, impressions, and number of ads
    
**`/facebook_ads_v2/funder_demographics`**
-   Sends full demographic and regional data on each ad by the funding entity that was active during the timeframe, along with each ad’s page id (for page filtering)
    
**`/facebook_ads_v2/funder_timeline`**
-   Sends the a list of the days each ad by the funding entity was active during the timeframe, along with the ad’s page ID and spend range

**`/facebook_ads_v2/funder_map`**
    -   Extra URL params: page_id
-   Gathers the data inside of each `delivery_by_region` field for each ad. Calculates the average audience as a percent, for each state/region belonging to the country. Aggregates any region outside of the country towards one percent, which gets labelled as "Unknown".
-   Also totals up the min spend and the max spend for each region to get a complete range.
-   Sends this data to the map module.

**`/facebook_ads_v2/frequency_table`**
    -   Extra URL params: page_id
-   Calls the `createAdsSummaryTable()` function which processes the creative_bodies fields, aggregates the frequency of them and returns `adsSummaryTable`

**`/facebook_ads_v2/funder_word`**
    -   Extra URL params: page_id, ~~is_wordcloud~~ UNUSED
-   This endpoint calls the API running under `/keywords_extractor`, the data processing is handled there.


## ❇️ Front End

The front end has a typical EJS layout with a views folder containing the templates and custom JS, and a public folder with images, css, and extra javascript files. The main files you need to pay attention to are:

-   views/**index.ejs** - the parent template for both the status page and main dashboard; includes links to JS and CSS
-   views/**status.ejs** - the status page’s body
-   views/**facebook_ads.js** - the layout for the dashboard
-   views/partials/**top_funders.ejs** - contains layout and scripts for the left column (heatmap & summary statistics)
-   views/partials/**summary.ejs** - contains layout and scripts for the right column (funder/page-specific stats, “about” section)
-   views/partials/footnotes/***.ejs** - these are used to add footnotes below the right column with information about the partner institution. Anything you put here will only appear on the page of the country corresponding to the files name (see au.ejs for an example from Australia)
