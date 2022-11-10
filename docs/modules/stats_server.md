# Stats server

---
[**Github repo**](https://github.com/FIIT-TEAM8/stats_server)

---

We use python Flask for our stats server. This service returns statistics that are calculated from articles matching a given user's query.


### Parameters

Parameters are the same as in our main Flask API server (excluding page number).

* q - search query
* from - YYYY-MM-DD date, starting publishing date for articles returned by this request
* to - YYYY-MM-DD date, ending publishing date for articles returned by this request
* keywords - [category 1, category 2, ...] list of categories of searched keywords
* regions - [sk, hu, it, ...] list of regions of articles to be returned


### Examples

```
curl -X GET https://adversea.com/stats/api/search?q=robert+fico
```
```
curl -X GET https://adversea.com/stats/api/search?q=Marian+Kocner&regions=[sk, cz, it]&keywords=[Fraud, Violence, Financial crimes]
```


### Sample response

```
{
    "articles_count": 27,
    "query": "Marian Kocner",
    "search_from": "",
    "search_to": "",
    "stats": {
        "articles_by_crime": {
            "Antitrust": [
                "6240f3e3fcf239665d512756",
                "62709aceabf5bf8856f1a62f"
            ],
            "Assault": [],
            ...
        },
        "articles_by_date": {
            "623ea8294f6d0b2df2d43670": "2018-10-08",
            "624093593f41c127d0432af1": "2018-02-27",
            ...
        },
        "articles_by_language": {
            "cs": [
                "624b1ade431fce169efa1159",
                "623ea8294f6d0b2df2d43670"
            ],
            "it": [],
            "sk": []
        },
        "articles_by_region": {
            "cz": [
                "624b1ade431fce169efa1159",
                "623ea8294f6d0b2df2d43670"
            ],
            "it": [],
            "sk": []
        }
    },
    "total_results": 27
}
```
