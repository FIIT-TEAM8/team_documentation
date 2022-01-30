# API routes


## Search articles
This returns articles that match a given query

### Parameters

* q - search query
* from - YYYY-MM-DD date, starting publishing date for articles returned by this request
* to - YYYY-MM-DD date, ending publishing date for articles returned by this request
* locale - locale of returned articles

### Examples

```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v2/search/?q=Marian+Kocner
```
```
curl -X GET https://team08-21.studenti.fiit.stuba.sk/api/v2/search/?q=Marian+Kocner&locale=en-gb&from=2020-01-01&to=2021-01-01
```

### Sample response

```
{
  "locale": "",
  "query": "Marian Kocner",
  "result_count": 2,
  "results": [
    {
      "body": "Article body.",
      "link": "https://thispersondoesnotexist.com/",
      "locale": "en-gb",
      "published": "2020-01-01",
      "title": "Sample article number 0"
    },
    {
      "body": "Another article body",
      "link": "https://thispersondoesnotexist.com/",
      "locale": "en-gb",
      "published": "2020-01-01",
      "title": "Sample article number 2"
    }
  ],
  "search_from": "",
  "search_to": ""
}
```