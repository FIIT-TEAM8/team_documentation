# API routes


## Search articles
This returns articles that match a given query

### Parameters

* q - search query
* from - YYYY-MM-DD date, starting publishing date for articles returned by this request
* to - YYYY-MM-DD date, ending publishing date for articles returned by this request
* page - number of current page
* size - current maximum number of articles per page (can be up to 20)
* keywords - [Keyword 1, Keyword 2, ...] list of searched keywords (same format as in Elasticsearch)
* regions - [sk, hu, it, ...] list of regions of articles to be returned

### Examples

```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v4/search?q=Marian+Kocner
```
```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v4/search?q=Marian+Kocner&regions=[sk, hu, it]&keywords=[Bomb Threat, Murder]&from=2020-01-01&to=2021-01-01&page=2&size=10
```

### Sample response

```
{
  "page_num": 1,
  "per_page": 10,
  "query": "Marian Kocner",
  "results": [
    {
      "link": "https://thispersondoesnotexist.com/",
      "locale": "en-gb",
      "published": "2020-01-01",
      "title": "Sample article number 0"
    },
    
    ...
  
  ],
  "search_from": "",
  "search_to": "",
  "total_pages": 15,
  "total_results": 156
}
```

## Display articles in archive
This returns one article that match a given link

### Parameters

* link - link of article to be retriewed

### Examples

```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v4/archive?link=https://www.bbc.com/news/world-middle-east-35219693
```

### Sample response

```
  {
  "article": 
    {
      "_id": "6239b1eddf4b7decb33fbaf2",
      "html": "scraped html",
      "keywords":["Assassination"],
      "language":"en",
      "link": "https://thispersondoesnotexist.com/",
      "published": "2020-01-01",
      "region":"gb",
      "title": "Sample article number 0"
    }
}
 ```
  
## Get articles for PDF report
This returns one or multiple articles that match a list of given ids

### Parameters

* ids - [id1, id2, id3, ...] list of article's ids to be retriewed

### Examples

```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v4/report?ids=[6239b1eddf4b7decb33fbaf2, 206239b1ecdf4b7decb33fbaee]
```

### Sample response

```
  "results": [
    {
      "_id": "6239b1eddf4b7decb33fbaf2",
      "html": "scraped html",
      "keywords":["Assassination"],
      "language":"en",
      "link": "https://thispersondoesnotexist.com/",
      "published": "2020-01-01",
      "region":"gb",
      "title": "Sample article number 0"
    },
    {
      "_id": "206239b1ecdf4b7decb33fbaee",
      "html": "scraped html",
      "keywords":["Assassination", "Murder"],
      "language":"en",
      "link": "https://thispersondoesnotexist.com/",
      "published": "2020-01-01",
      "region":"gb",
      "title": "Sample article number 1"
    },
    
    ...
  
  ],
  ```
