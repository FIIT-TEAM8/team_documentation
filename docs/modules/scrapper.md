# Scrapper

---
[**Github repo**](https://github.com/FIIT-TEAM8/scraper)

---

The scrapper works by reading the Google news RSS stream source using various crimes as keywords. After getting article links from Google news, we parse the source page HTML by extracting only heading and paragraph tags, stripping the content to the bare minimum. This text is than saved to MongoDB and a crime that was used to find this article is linked to the article ID.




## Development
  * git clone <url>
  * go to repository folder
  * python -m venv .\venv
  * .\venv\Scripts\activate
  * pip install -r requirements.txt


### Database connection
This application expects that you have a running mongoDB instance ready. Check **scraper/scraper/google_news/settings.py** for variables starting with **MONGO_DB** to see how the configuration is managed. In short, the connection is assembled with these environment variables:

 * MONGO_SERVER_URL - URL to server running mongoDB. Default is **localhost**
 * MONGO_SERVER_PORT - port for mongoDB. Default is **27017**
 * MONGO_USER - user used for connection do db. Default is **root**
 * MONGO_PASSWORD - password for said user. Default is **example**
 * MONGO_DB - database name to be used. Default is **ams_db**

### Running the scrapper
This application can be launched using two different methods: standalone or using scrapyD server abstraction. For quick testing when developing, the standalone method is sufficient. Details about scrapyD are discussed in the **ScrapyD** chapter. 

For running the scrapper in standalone mode, follow these steps:

  * cd .\scraper
  * scrapy scrawl news_spider <ARGUMENTS>

Where arguments can be:
  * crimes_file=<FILENAME> - filename of crimes to parse. (murder.txt / list_of_crimes.txt / 1_part.txt etc.) The path to file should be relative from **scraper/scraper/crimes/** folder.
  * search_from=YYYY-MM-DD - date
  * search_to=YYYY-MM-DD - date
  * locale=locale - set your locale (en-gb / sk-sk etc.) Available locales are listed in scraper/scraper/gnewsparser/\_\_init\_\_.py file in \_\_LOCALE variable. Each locale code represents LANGUAGE-COUNTRY combo.
 
Arguments need to be passed using scrapy anotation, with the _-a_ switch.
Example:
 
```
 scrapy crawl news_spider -a crimes_file=murder.txt -a search_from=2020-01-01 -a search_to=2020-01-05 -a locale=en-gb
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
curl localhost:6800/schedule.json -d spider=news_spider -d project=ams -d search_from=2021-11-14 -d search_to=2021-11-28 -d locale=en-gb -d crimes_file=list_of_crimes.txt
```


## Deployment
After any commit / merge to the main branch, a github action is ran that builds the docker image, pushes it to dockerhub and updates the running container on our production server.


## Testing:
All unit tests are located inside the **test** folder. We use python unittest for testing this code. Run this commad in the root of this repository:

```
python -m unittest discover
```