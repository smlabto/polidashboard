# Overview

The dashboard consists of:

1.  A data collector, written in python, which collects ads from the Facebook API
    
2.  A Mongo database
    
3.  A Node app, which serves the website and handles database queries
    
4.  A front end, written in vanilla javascript with EJS and D3.js
    

# Adding New Countries

## Data Collector

1.  Create a cron job to collect ads every four hours. This will automatically generate all of the necessary database collections and indexes the first time it is run.
    

  

python collector/collect.py [two-letter country code]

  

## Frontend

1.  Add data on the new country to node/countries.json
2. Set “first date” to the oldest date (dd-mm-yyyy) for which data is available for the country - this will set the minimum date in the date selector
3.  Set “regions” to contain a mapping of the country’s longform regions/states/provinces to the abbreviations that’ll be shown on the regions chart
4. Regions that are present in the data but aren’t included in this mapping will be printed to the console and shown under ‘other’ on the dashboard. Use this to identify any territories / regions that you might have missed (like Puerto Rico). You need the long versions of each of the region names to match the ones Facebook uses.
5.  Set “currency” to a three letter currency code (e.g. “CAD”, “USD”, or “EUR”)
6.  Set “currency_symbol” to the symbol used to abbreviate the currency (e.g. “$”, “£”, or “€”)
7.  Set “name” and “code” to the country’s name and two letter code (lower case)    
8.  If you need a footnote (i.e. the “Partner Institution” box), place it in node/views/partials/footnotes/[country code].ejs - see au.ejs as an example. Whatever you place in this file will automatically be added below the summary tab, and you can put any country-specific CSS in here as well
    

# Updating API Keys

The Meta Ad Library API key needs to be updated every two months. To do this, update or get new keys got to GRAPH API explore from [https://developers.facebook.com/tools/explorer/](https://developers.facebook.com/tools/explorer/)


and paste it into ~/facebook_dashboards/collector/collect.py. You don’t need to restart anything - the new key will be used automatically next time the collector’s CRON job runs.

# Collector

The important part of the collector is in collector/collect.py  (the other files in the collector module are provided by Facebook). 
"collect.py" accepts the country code (i.e. ca, us) as an argument, and has a method to update each of the five Mongo collections for each ad.

## Logging

The collector stores its logs in node/public/logs.txt. This file is publicly accessible through the node app, and is used by the status page to determine the collector’s status. You can set a CRON job to automatically flush the logs to ~/old_logs/ on the first of each month:

> 1 1 1 * * mv /home/ubuntu/facebook_dashboards/node/public/log.txt
> /home/ubuntu/old_logs/logs_$(date "+%Y-%m").txt

# Database

For each of the entities below, there is a collection for each country (e.g. facebook_timestamps_ca, facebook_timestamps_us, etc). It’s organized as follows:
![enter image description here](https://polidashboard.com/wp-content/uploads/2022/11/database.jpg)

1.  **Timestamps** (e.g. facebook_timestamps_ca)
-   The collector queries every active ad each time it runs, and their IDs and timestamps are recorded here
-   One ad has many documents in this collection
-   The delivery start and end times provided by Facebook aren’t necessarily accurate - sometimes ads are temporarily deactivated
-   Any query with a timeframe should check this table
-   Indexes: _id.timestamp, _id.ad
    
2.  **Ads** (e.g. facebook_ads_ca)
-   This contains all the ad-specific metadata provided by Facebook, including funding entity, impressions, spend range, and page ID
-   Each ad has only one document in this collection, which is updated each time it is collected
-   Indexes: _id, funding_entity
    
3.  **Audiences** (e.g. facebook_audiences_ca) 
-   All of the demographic data is recorded here
-   There is one document for every non-zero ad ID/gender/age combination, and they’re updated each time the ad is collected
-   Indexes: _id.ad
    
4.  **Regions** (e.g. facebook_regions_ca)
-   This table stores data on regional impressions in the same structure as the audiences table    
-   There is one document for each region/ad ID combination
-   Indexes: _id.ad
    
5.  **Pages** (e.g. facebook_pages_ca)
-   This table just maps page IDs to their names, so that changes in page names will be reflected across the dashboard
-   Indexes: _id

The indexes are handled automatically by the collector.

# Node Application

## Routes

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
    

## Polidashboard API

The node application provides several API endpoints to fill the data on the front-end. Their queries and code can be found in node/facebook_routes.js. In general, date ranges are represented by integers startDay and endDay, where the days are numbered backwards (today is day 0, yesterday is day 1, etc). The routes are as follows:

**/status/country**
 -   URL params: country
	-   Returns the timestamp of the most recent document in that country’s database, and the total number of ads collected for the country to date
    
**/facebook_ads_v2/heatmap**
    -   URL params: startDay, endDay
 - Sends the number of ads posted by each funder in each spend range,
   used to fill the heatmap on the left
-   This query is automatically cached every four hours for each country
    

**/facebook_ads_v2/funder_pages**
    -   URL params: startDay, endDay, funder, country 
-   Sends data on each of the pages a funding entity as supported, including spend range, impressions, and number of ads
    
**/facebook_ads_v2/funder_demographics**
    -   URL params: startDay, endDay, funder, country
-   Sends full demographic and regional data on each ad by the funding entity that was active during the timeframe, along with each ad’s page id (for page filtering)
    
**/facebook_ads_v2/funder_timeline**
    -   URL params: startDay, endDay, funder, country
-   Sends the a list of the days each ad by the funding entity was active during the timeframe, along with the ad’s page ID and spend range
    

# Front End

The front end has a typical EJS layout with a views folder containing the templates and custom JS, and a public folder with images, css, and extra javascript files. The main files you need to pay attention to are:

-   views/**index.ejs** - the parent template for both the status page and main dashboard; includes links to JS and CSS
-   views/**status.ejs** - the status page’s body
-   views/**facebook_ads.js** - the layout for the dashboard
-   views/partials/**top_funders.ejs** - contains layout and scripts for the left column (heatmap & summary statistics)
-   views/partials/**summary.ejs** - contains layout and scripts for the right column (funder/page-specific stats, “about” section)
-   views/partials/footnotes/***.ejs** - these are used to add footnotes below the right column with information about the partner institution. Anything you put here will only appear on the page of the country corresponding to the files name (see au.ejs for an example from Australia)
