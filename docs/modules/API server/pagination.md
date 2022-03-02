# Pagination

Every search returns the top 10 most relevant articles by default. This value is stored in search parameter `size` and can go 
up to 20 articles per page. Another important search parameter is `page`, which states the current page number (default is 1). 
Their values are validated before further actions so they can't be lesser than zero. If this is the case, they are changed to their default values.

Both of these parameters are used to paginate through the set of returned results. Here are also used Elasticsearch's `from` and `size` parameters,
where `from` states the number of results to skip and `size` states the maximum number of results to return.
In the sample below we can see how is the `from` parameter calculated. If the `page_num` is 1 and `size` is 10 then it's value will be 0.
If we switch to page 2, the value will increase to 10, if to page 3, then 20 and so on.

### Sample query
```
body = {
        "from": page_num * size - size,
        "size": size,
        "query": {
            "multi_match": {
                "query": query,
                "fields": ["text"]
            }
        }
    }
```

After retrieving documents with this query we can calculate number of total pages and total results. Response to the web server contains both of 
these parameters, plus the number of current page and number of articles per page.

### Sample response
```
response = {
        "query": query,
        "search_from": search_from,
        "search_to": search_to,
        "locale": locale,
        "page_num": page_num,
        "per_page": per_page,
        "total_pages": total_pages,
        "total_results": total_results,
        "results": articles
    }
```
