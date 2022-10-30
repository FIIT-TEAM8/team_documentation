# Scrapper

---
[**Github repo**](https://github.com/FIIT-TEAM8/scraper)

---

The scrapper works by reading the Google news RSS stream source using various crimes as keywords. After getting article links from Google news, we parse the source page HTML by extracting only heading and paragraph tags, stripping the content to the bare minimum. Scraper saves scraped article in MongoDB. After sucessfull saving MongoDB returns article's *\_id*, which refers to the item in DB and document in Elasticsearch index, because in the end of the pipeline scraper indexes scraped document.

This table contains fields, which are stored in each item in MongoDB and each document in Elasticsearch index

| Field name | MongoDB Type | Elastic | Description |
| ------------- | ------------- | ----------- |----------- |
| html  | `string`  | `text`  | HTML of scraped article |
| publish | `string`  | `text` | published date of the article |
| link | `string`  | `text` | link to the article |
| region | `string`  | `text` | article's region |
| language | `string`  | `text` | article's language |
| keywords | `array`  | `text` (actually array, ref. tip) | crime keywords, which are mentioned in article's text |
| title | `string`  | `text` | article title |

!!! tip "Fun fact / tip"
    In Elasticsearch, there is no dedicated array data type. Any field can contain zero or more values by default, however, all values in the array must be of the same data type. [source](https://www.elastic.co/guide/en/elasticsearch/reference/current/array.html)
    
!!! warning "Keywords are always in english, even when text of the scraped article is in different language."

## Proxies
After some time, google news rss stream started detecting that we were a scraping bot. To avoid this and keep scraping articles, we use proxies. However, these proxies will also get banned, if they keep the same IP addresses. For this issue, we use TOR network proxies. Scraper rotates between TOR proxies that switch IP address every 15 seconds.


## Development
  * git clone <url>
  * go to repository folder
  * python -m venv .\venv
  * .\venv\Scripts\activate
  * pip install -r requirements.txt

After that put a ".env" file inside scraper/scraper/google_news. This file can contain your system variables for scrapy. This file will not get versioned.

    
 ### Development environment
Setup [development environment](../devEnvironment.md) according to it's documentation. Do not forget to also start your proxies (also part of the linked documentation page).
    

### Database connection
This application expects that you have a running mongoDB instance ready. Check **scraper/scraper/google_news/settings.py** for variables starting with **MONGO_DB** to see how the configuration is managed. In short, the connection is assembled with these environment variables:

 * MONGO_SERVER_URL - URL to server running mongoDB. Default is **localhost**
 * MONGO_SERVER_PORT - port for mongoDB. Default is **27017**
 * MONGO_USER - user used for connection do db. Default is **root**
 * MONGO_PASSWORD - password for said user. Default is **example**
 * MONGO_DB - database name to be used. Default is **ams_db**
 
### Elasticsearch connection
 * ES_HOST - URL to server running Elasticsearch. Default is **localhost**
 * ES_PORT - port for Elasticsearch. Default is **9200**
 * ELASTIC_INDEX_CONFIG - name of the index configuration file. Default is **articles_index_config.json**
 * ELASTIC_INDEX_NAME - name of the index, which is created based on index configuration file. Default is **articles_index**
    

### Running the scrapper
This application can be launched using two different methods: standalone or using scrapyD server abstraction. For quick testing when developing, the standalone method is sufficient. Details about scrapyD are discussed in the **ScrapyD** chapter. 

For running the scrapper in standalone mode, follow these steps:

  * cd .\scraper
  * scrapy crawl news_spider <ARGUMENTS>

Where arguments can be:
    
  * crimes_file=<FILENAME> - filename of crimes to parse. (list_of_crimes_english.txt / list_of_crimes_slovak.txt / etc.) The path to file should be relative       from **scraper/scraper/crimes/** folder.
  * search_from=YYYY-MM-DD - date
  * search_to=YYYY-MM-DD - date
  * locale=locale - set your locale (en-gb / sk-sk etc.) Available locales are listed in scraper/scraper/gnewsparser/\_\_init\_\_.py file in \_\_LOCALE variable. Each locale code represents LANGUAGE-COUNTRY combo.
 
!!! warning "Some countries doesn't support LANGUAGE-COUNTRY combo and are only accessible with [language](https://developers.google.com/admin-sdk/directory/v1/languages). Scraper can handle it, but leave blank string in region in both MongoDB item and Elasticsearch document."
 
Arguments need to be passed using scrapy anotation, with the _-a_ switch.
Example:
 
```
 scrapy crawl news_spider -a crimes_file=list_of_crimes_english.txt -a search_from=2020-01-01 -a search_to=2020-01-05 -a locale=en-gb
```
    

### Publishing changes to Github
Very important note here: If you install a new package using **pip**, don't use pip freeze for updating the requirements.txt file. This can and probably will cause trouble in production if you developed your changes on windows machine. For the best compatibility, use command pip-chill to update requirements.txt. Example:

```
pip-chill > requirements.txt
```


## ScrapyD
For easier controll of our scraper, we use ScrapyD. It is a simple web-server wrapper on top of our scrapper, allowing us to control our data scraping using HTTP methods. This is a bit hassle to run this on both windows and linux platforms well, so the best way to test if your changes run good inside ScrapyD, build a docker image using the Dockerfile inside your repository. Run the container and forward the exposed port (6800). Don't forget to set environmental variables for your MongoDB connection. 

To schedule a spider, you can use any HTTP tool you wish. On most linux machines, curl is available and can be used like this:

```
curl -u username:password localhost:6800/schedule.json -d spider=news_spider -d project=default -d search_from=2021-11-14 -d search_to=2021-11-28 -d locale=en-gb -d crimes_file=list_of_crimes.txt
```
Username and password for scraper is stored in our keepass password vault as **Scraper login**
    
ScrapyD can also limit the number of concurent spiders, which at this moment is configured to 5. This means that at any moment, maximum number of 5 spiders can run concurrenly. Other spiders will be waiting in **pending** state and are executed when there is a free spot.


## Deployment
After any commit / merge to the main branch, a github action is ran that builds the docker image, pushes it to dockerhub and updates the running container on our production server.
    
## Automatic scheduling
Scraper is currently configured to run every day at 05:00 to scrape articles from the previous day. It is achieved by utilizing **cron** that runs a python script. It is communicating to scrapyd server and runs a job for every region we support. This scheduler is it's own very small module and is deployed as a standalone docker container on our service infrastructure machine. The source code can be found [here](https://github.com/FIIT-TEAM8/scraping_scheduler)


## Testing:
All unit tests are located inside the **test** folder. We use python unittest for testing this code. Run this commad in the root of this repository:

```
python -m unittest discover
```
