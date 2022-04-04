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
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v2/search/?q=Marian+Kocner
```
```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v4/search/?q=Marian+Kocner&regions=[sk, hu, it]&keywords=[Bomb Threat, Murder]&from=2020-01-01&to=2021-01-01&page=2&size=10
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
    {
      "link": "https://thispersondoesnotexist.com/",
      "locale": "en-gb",
      "published": "2020-01-01",
      "title": "Sample article number 2"
    },
    
    ...
  
  ],
  "search_from": "",
  "search_to": "",
  "total_pages": 15,
  "total_results": 156
}
```
