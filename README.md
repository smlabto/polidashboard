<div  align="center">

<a  href="#"><img  src="https://socialmedialab.ca/wp-content/uploads/2022/05/TMU_TRSM_SocialMediaLab_transparent_WHITE-1.png.webp"  height="50px"  /></a>

<h1></h1>

<a  href="https://polidashboard.org/"  target="_blank">

<img  src="https://app.polidashboard.org/images/PoliDasboard-SocialLogo.png"  height="100px"  />

</a>

</div>

  

## ❔About

  

PoliDashboard is an app for tracking political advertisements on Meta-owned advertising platforms such as Facebook and Instagram. It is designed to help voters, journalists, campaign staffers and others to track the use of targeted ads around social issues, elections or politics.

  

The dashboard is developed by the Social Media Lab at Toronto Metropolitan University as part of an international election transparency initiative.

  
  

## ❇️ Overview

  

The dashboard consists of:

  

1. A data collector, written in python, which collects ads from the Facebook API | `/collector`

2. A Node app, which serves the website and handles database queries | `/webapp`

3. A front end, written in vanilla javascript with EJS and D3.js | `/webapp`

4. A Postgres database, relevant scripts found in | `/postgresql`

5. A Redis server

  
  

## ❇️ Installing and Running the App

- **Node.js** >= 18.0.0 (you can use [nvm](https://github.com/nvm-sh/nvm) to install/manage)
  

Make sure to have node installed on the system. Install npm dependencies and run node application:

`cd webapp`

`npm install`

`npm start`
  

**Install postgresql (tested with ver.17) using:**

`sudo apt install postgresql`

`sudo systemctl start postgresql`

Install the PostgreSQL client:
`sudo apt install postgresql-client`
  

**Install redis using:**

`sudo apt install redis-server`

`sudo systemctl start redis`

  

**Set postgres and redis to launch on boot:**

`sudo systemctl enable redis`

`sudo systemctl enable postgresql`

  
  

## ❇️ Database

Polidashboard stores the ad data that come from Meta's platforms inside of Postgres. Before fetching any data from Meta, it is necessary to create the required database and tables with the following instructions:

  

**Create the admin user:**

`sudo -u postgres psql -c "CREATE ROLE \"polidashboard-admin\" WITH LOGIN PASSWORD 'admin';"`

  

**Creating the database:**

`sudo -u postgres createdb polidashboard -O "polidashboard-admin"`

  

**Give the admin user permissions:**

`sudo -u postgres psql -d polidashboard -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO \"polidashboard-admin\";"`

  

**Create the viewer user and give it permissions on the polidashboard database:**

`sudo -u postgres psql -c "CREATE ROLE \"polidashboard-viewer\" WITH LOGIN PASSWORD 'viewer';"`

`sudo -u postgres psql -d polidashboard -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO \"polidashboard-viewer\";"`

  

From here, change passwords as you see fit

  

**Create the tables in the database:**

Polidashboard uses tables partitioned by countries to reduce query time. Each main table [`ad_data`, `ad_region`, `ad_demographic`, `ad_creative_content`] is a partitioned table with partitions [`ad_data_ca`, `ad_data_us`, `ad_region_ca`, `ad_region_us`, etc...].

Each of these partitions as well as their indexes have to be created individually. To simplify this, we provide 4 `.sql` files [`ad_data_partitions.sql`, `ad_creative_content_partitions.sql`, `ad_region_partitions.sql`, `ad_demographic_partitions.sql`]

These `.sql` files will create the partitions for each of the main tables which are created using `tables.sql`. You can run all 5 files together in the correct order using the `create_polidashboard_db.sql` file like so:

`sudo -u postgres psql -d polidashboard -f create_polidashboard_db.sql`

  

### ➕ Database Structure

Each of the tables below are partitioned by country (i.e. ad_demographic is partitioned into ad_demographic_ca, ad_demographic_us, …).

  

**Shared fields:**

(id, country, ad_delivery_start_time, ad_delivery_stop_time, latest_collected, platforms_facebook, platforms_instagram, platforms_other, platforms, page_id, page_name, bylines_name)

  
**Tables:**

**`ad_data`**

Additional fields: (id, ad_creation_time, ad_snapshot_url, currency, impressions_lower_bound,

impressions_upper_bound, spend_lower_bound, spend_upper_bound,

audience_lower_bound, audience_upper_bound, languages)

  

This contains all the ad-specific metadata provided by Facebook, including funding entity, impressions, spend range, and page ID.

Each ad has only one document in this collection, which is updated each time it is collected.

  

**`ad_demographic`**

Additional fields: (gender, age_range, age_percent, age_impressions_lower_bound, age_impressions_upper_bound, age_spend_lower_bound, age_spend_upper_bound)

All of the demographic data is recorded here, the estimated impressions and spending are calculated by multiplying age_percent with the impressions and spending fields from the corresponding ad in ad_data.

There will usually be multiple entries per ad, as each combination of age range and gender will need its own entry.

**`ad_region`**

Additional fields: (region, region_percent, region_impressions_lower_bound, region_impressions_upper_bound, region_spend_lower_bound, region_spend_upper_bound)

All of the region data is recorded here, the estimated impressions and spending are calculated by multiplying region_percent with the impressions and spending fields from the corresponding ad in ad_data.

There will usually be multiple entries per ad, as each region will need its own entry.

  

**`ad_creative_content`**

Additional fields: (content_order, body, caption, descript, title)

All of the text content data is recorded here.

There can be multiple entries per ad as each ad can have multiple text entries. There is an additional content_order field to differentiate between each entry, as each entry is stored in a specific order in the original API data.

  
  

## ❇️ Ad Collection

  

### ➕ Overview

All ad collection scripts are located inside of the `/collector` directory. Ad collection works by fetching active/inactive ads that were running between now and 2 previous days. A two-letter country code must be defined as a parameter when running the collection script, which will fetch ads from funders of that country. (this two date limit can be modified via the `collect.py` script, but note that the more days you collect, the longer the collection process will run, which could prevent you from collecting from multiple countries smoothly).

  

`collect.py` is the primary collection script and is responsible for setting up the request for ads to Meta's API and also inserting the ad data into Postgres. It takes in 1 parameter which is a two-letter country code (ex. `ca`, `au`, `fr` ...)

  

`fb_ads_library_api.py` is taken from Meta's API Script Repository. It has been modified slightly to service this application and is directly responsible for fetching the ads from the API. This script is used by `collect.py`

  

`push_to_dbs.py` defines a class that packages the data from Meta ads and prepares it for Postgres insertion. This script is used by `collect.py`

  

`recollect_inactive.py` is a collection script to specifically collect any ads that `collect.py` failed to update as inactive.

  

### ➕ Getting API Credentials

  

Before running any ad collection, an API token is required from Meta’s Graph API.

  

To obtain one, first login to [https://developers.facebook.com/](https://developers.facebook.com/) and create a developer account using a Facebook account.

>  *Note that to create a developer account you will be required to upload some type of identification. Without doing this you will be unable to fetch ad data.*

  

1. Once logged in, access the Apps page and create a new app.

2. On the first page give it a name and then on the *Add use case* page select the last option **"Other"**.

3. For the app type select **Business** and then finish creating the App.

4. Once the app has been created, under the Tools option on the header select Graph API Explorer.

5. On the right side, make sure the app that was just created is selected and then add a new permission called “ads_read”.

6. Once this is done, click Generate Access Token and copy the access token.

  

Note that this token can be used for collection but it will expire very quickly and is not ideal for long term collection. Long lived tokens that last up to 2 months can be created by selecting **Access Token Debugger** from the Tools dropdown. From there you can paste the Access Token copied from earlier, hit Debug and then at the bottom click “Extend Access Token”. A new token will appear at the bottom of the page and this token can be used for collection.

(Make sure to refresh the token every two month to prevent disruption to data collection)

  

You can learn more about the [Meta Ad Library API here](https://www.facebook.com/ads/library/api/)

  

### ➕ Setup & Run Collection

  

The collector requires an API token from a Meta Developer account. After following the steps in the previous section, create an environment variable called `FACEBOOK_API_KEY` and paste the access token. In order to collect data, you simply need to run the collect.py script like so: 

`cd polidashboard/collector`

`../collector/collect.py ca`

  

The parameter `ca` represents a country code (in this case Canada) and any other country can be put in its place instead if you want to collect from a different country. Since returned ad data is only from the past 2 days, the ideal way of collecting ad data (over a period longer than 1 day) is to set up a cron job to run periodically, usually every 24 hours.

  

There are also environment variables that are located inside of `push_to_dbs.py` that are used to connect to Postgres, and also to manage ssh tunneling (if required). By default, they are set to the default username/passwords/ports, but should be changed if you are using custom credentials/settings.

  

An example inside of crontab would be (make sure to define the Meta access token in your crontab for collection to work):

`FACEBOOK_API_KEY=access_token_here`

`0 12 * * * /usr/bin/python3 /…/polidashboard/collector/collect.py ca`

  

### ➕ Setup Inactive Recollection

  

> This section describes an observed issue with a *very* small number of ads that don't reappear as expected in the primary `collect.py` script. This can cause a slight divergence in advertiser statistics from Meta's Ad Library. If you identified ads with this issue and would like to fix them or you're very concerned about data integrity, please continue reading, if not, you are free to skip this section.


It is not possible to obtain the status of an ad via the Meta Ad Library API, and because of this, some problems arise. We noticed that some ads don't appear when querying consecutively over several days with the url generated via the `collect.py` script.

  

An example scenario is when a currently active ad gets missed from the main collector over several days consecutively. Let's say it is collected on the first day, and we have data saying it received 500 minimum impressions. Then overtime, this ad accumulated 50k minimum impressions. Because we missed the ad in the primary collection, this field never gets updated so in the database 500 minimum impressions are still recorded.

Then should that ad be set to `Inactive` by the advertiser, and we still don't collect it over the next two days, that data will effectively be missing.

  

Another problem on top of this is that Polidashboard will then make use of the last collected time rather than the official date the ad stopped running, which results in inaccurate filtering of when ads were running.

  

This specific scenario is why we developed the `recollect_inactive.py` script. It will look inside of the database and find which ads need to be recollected.

  

Meta’s API does not allow querying for specific ad ids, so to get around this we first get the list of our inactive ads. Since Meta does not provide the ad status to us, we have to make the assumption that if the `ad_delivery_stop_time_raw` (this is why we have this field stored in Postgres) field is set to null, and the last time we collected it was less than 2 days, then we know that ad is likely an ad we missed data for and need to update. The script then goes down the list of ads that may be inactive and keeps looking through them until it has encountered 10 unique page ids. The list is filtered by date time to try and minimize the range of time we look in order to minimize the number of ads/API calls. Once this has been done we build a request URL based on the oldest and newest date we could find of all the ads we just passed, doing this until all ads have been updated, or if we have exhausted all requests.

  

The script will do this process for each country pulling the list of countries directly from `webapp/countries.json` (or for a specific country if country code parameter is given). This script is very slow, especially when collecting from multiple countries or if there are many inactive ads that need recollection. It is ideal to run this script every 2 weeks via crontab, and it is recommended to make adjustments to necessary variables (such as looking back 2 days, if you also changed the number of days as well in the main collect.py script)


The `recollect_inactive.py` also requires your API access token to your environment variables as `FACEBOOK_API_KEY_CLEANUP`


The `recollect_inactive.py` also uses a separate API script `fb_ads_library_cleanup.py`, this is for finer control of the request URL + processing ads returned (most important part is being able to set the start time and end time directly)

  

## ❇️ Adding New Countries

You will need to create the respective partition tables in the PostgreSQL database for the new country. We suggest using the provided `create_new_partitions.py` file by running: 

`python create_new_partitions.py [two-letter country code]`

This will create a new_partitions.sql file that you can now execute using PostgreSQL to add the new partition and indices.

  

### ➕ Frontend

  

Add the following relevant data on the new country to `webapp/countries.json`. Adding a country to this file will make it appear as an option in the dropdown on the front page.

1. Set `“first date”` to the oldest date (dd-mm-yyyy) for which data is available for the country - this will set the minimum date in the date selector

2. [UNUSED] Set `“regions”` to contain a mapping of the country’s longform regions/states/provinces to the abbreviations that’ll be shown on the regions chart

3. Set `“currency”` to a three letter currency code (e.g. “CAD”, “USD”, “EUR”, etc.)

4. Set `“currency_symbol”` to the symbol used to abbreviate the currency (e.g. “$”, “£”, “€”, etc.)

5. Set `“name”` and `“code”` to the country’s name and two letter code (lower case)

  

### ➕ Adding Country Map

  

PoliDashboard makes use of TopoJSON files to render the map modules. The generation of the map is handled in the `Statemap` class, located at `webapp/views/partials/statemap.ejs`, the TopoJSON data is loaded from `webapp/public/maps/` by the `fetchTopoData()` function.

  

The TopoJsons need to be cut up in a way that it matches the states/regions of the data Facebooks API provides us from the `delivery_by_region` field. We primarily get these from [https://code.highcharts.com/mapdata/](https://code.highcharts.com/mapdata/). However, sometimes the data Facebooks API gives us does not match up nicely with the TopoJsons provided by Highcharts (ex. this happened with Spain, as Facebook gave us the `delivery_by_region` data based on Spains autonomous regions, and Highchart did not have a map of Spain cut up by its autonomous regions. So if this happens, you will have to find a map that matches.) The TopoJSON should have a unique id for each region. Polidashboard associates the name of a region (given by facebooks `delivery_by_region` field) with the unique id of that region on the TopoJSON. This association needs to be manually created inside of `webapp/country_states.js` as a Map object of an array of `["Region Name from Facebook", "TopoJson ID"]` pairs for the country you want to add (It is also necessary to add an "Unknown" region, you can see each country has this region, it is for the Learn More section).

  

> If your TopoJSON does not have an id field for each region, or you can only find a GeoJSON of the country you are trying to add, you can use this tool [https://mapshaper.org/](https://mapshaper.org/). It accepts lots of file formats, including GeoJSON, and it can export into TopoJSON. The main thing you will want to do with this tool is rename the layer (at the top of the page) to `default` (because by default in the code, `topo_data = mapDataset.objects.default;`) and you can also add/modify the ID's of the map regions using the `edit attributes` tool. All you will need to add is an ID field (call the field `FID`).

  

Here is the general order of steps you should follow to add a country map:

1) Find document(s) in your MongoDB that has all, if not most, of the states inside of `delivery_by_region`.

2) Find a TopoJSON that has all of these states (should follow some kind of a government recognized standard that you can just wikipedia, then follow that to help you find a TopoJSON).

2.5 optional) Import the map into this handy tool [https://mapshaper.org/](https://mapshaper.org/) to modify layer name OR add/modify ids.

3) Add the TopoJson files under the `/public/maps/` directory, (it will automatically be read from the `fetchTopoData()` function)

4) Add the key `["Region Name from Facebook", "TopoJson ID"]` pairs to `webapp/country_states.js` for the country

>  \**At this point if you run the app you should see the map when that country + a funder is selected. If you don't see the map, check if it rendered inside of the svg out of bounds using inspect element, if you see a bunch of <path> objects then it worked, you just need to modify the transformations*

5) Add to the `transformations` object inside of the `Statemap` class your country, applying the necessary scale + translate (if country is upside down, y-scale needs to be negative)

[Optional] 6) If your country has a very small state that would be difficult to see/hover the mouse over, you can add to the `smallTerritoryBoxes` array an object that represents a box for that region.

  
  

## ❇️ Node Application

  

### ➕ Routes

  

**/meta_ads**

- URL Parameters:

- startDay - the oldest day to query (default is 7)

- endDay - the newest day to query (default is 0)

- Sends the site template with basic metadata for EJS:

- fbStartDay - the oldest day to query

- fbEndDay - the most recent day to query

- days - the number of days included

- child - the EJS template used to fill the body of the site (this is a legacy from an old version of the dashboard)

- country - the currently selected country (default is ‘ca’)

- validCountries - a list of all countries to include in the dropdown list (populated by countries.json)

- fs - filesystem, used for EJS templating

- firstDay - the first day for which there is data available for the country, used to set the minimum date in the date picker

- currency (default ‘CAD’)

- currencySymbol (default ‘$’)

  

### ➕ Polidashboard API

  

The node application provides several API endpoints to fill the data on the front-end. Their queries and code can be found in `webapp/facebook_routes.js`. In general, date ranges are represented by integers startDay and endDay, where the days are numbered backwards (today is day 0, yesterday is day 1, etc). The routes are as follows:

  

**`/status/country`**

- Renders a status page which shows the most recent timestamp of collection for each country and a status indicator which shows the most recent collection for each country occurred within the last 2 days.

> All endpoints below are cached for 12 hours in redis.

**`/meta_ads/heatmap`**

- POST request
- POST body params: `ageRanges`, `genders`, `regions`, `region_list`, `platforms`, `filterBy`, `startDay`, `endDay`, `country`, `startedDuring`
- Sends the number of ads posted by each funder in each spend range,

- Used to fill the main heatmap on the left side of Polidashboard


> The following endpoints below are all POST requests take in the same POST body parameters: `startDay, endDay, bylines, country, page_id, platforms, startedDuring`

  
**`/meta_ads/funder_pages`**

- Sends data on each of the pages a funding entity supported, including spend range, impressions, and number of ads

**`/meta_ads/funder_demographics`**

- Sends full demographic data for each ad posted by the funding entity that was active during the timeframe, along with each ad’s page id (for page filtering)

**`/meta_ads/funder_timeline`**

- Sends the a list of the days each ad by the funding entity was active during the timeframe, along with the ad’s page ID and spend range


**`/meta_ads/funder_map`**

- Gathers the data inside of each `delivery_by_region` field for each ad and aggregates the total impressions and spending in each region for the funder or page specified in the POST body.

**`/meta_ads/frequency_table`**

- Sends the text body content of all ads for the specified funder or page in the POST body, a duplicate number (`ad_count`) is sent instead of sending ads with duplicate text content


**`/meta_ads/funder_word`**

- Sends the most common and important keywords within the text content of the ads posted by the specified funder or page in the POST body
- Also sends the weight of the keywords, which can be used to generate a wordcloud

  
  

## ❇️ Front End

  

The front end has a typical EJS layout with a views folder containing the templates and custom JS, and a public folder with images, css, and extra javascript files. The main files you need to pay attention to are:

  

- views/**index.ejs** - the parent template for both the status page and main dashboard; includes links to JS and CSS

- views/**status.ejs** - the status page’s body

- views/**facebook_ads.js** - the layout for the dashboard

- views/partials/**top_funders.ejs** - contains layout and scripts for the left column (heatmap & summary statistics)

- views/partials/**summary.ejs** - contains layout and scripts for the right column (funder/page-specific stats, “about” section)

