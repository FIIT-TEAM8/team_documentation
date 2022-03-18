# Elasticsearch

---
[**Github repo**](https://github.com/FIIT-TEAM8/elasticsearch_mongo)

---

Elasticsearch runs in Docker container, with image docker.elastic.co/elasticsearch/elasticsearch:7.15.0
Our scraper communicate with Elasticsearch through [python library](https://elasticsearch-py.readthedocs.io/en/v7.15.1/). Make sure you are using the right version of library(7.15.1), otherwise some functionality will not work.

Elastic currently works with one shard and one replica.

```
"index": {
  "number_of_shards": 1,  
  "number_of_replicas": 1 
},
```

It uses Standard analyzer with filtering english stop words and converting text to lowercase.

```
"analysis":{
  "analyzer":{
      "english_stop_analyzer":{ 
          "type":"custom",
          "tokenizer":"standard",
          "filter":[
              "lowercase",
              "english_stop_words"
          ]
      }
},
"filter":{
  "english_stop_words": {
      "type": "stop",
      "stopwords":"_english_",
      "ignore_case": true,
      "remove_trailing": true
    }
  }
}
```

This type of analyzer is used during indexing documents and querying results. Each document contains this fields:

| Field name | Type | Description |
| ------------- | ------------- | ----------- |
| html  | `text`  | HTML of scraped article |
| publish  | `text` (production) \| published date of the article |
| link | `text` _(30 days)_ | link to the article |
| region| `text` | article's region |
| language | `text` | article's language |
| keywords | `text` | crime keywords, which are mentioned in article's text |
| title | `array` | article title |

Field values of each document are stored only in *_source* field, which is necessarry for some fundamental [functionality](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-source-field.html). Corresponding code to fields in configuration index file is below.

```
"properties": {
    "html": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "published": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "link": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "region": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "language": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "keywords": {
        "type": "array",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    },
    "title": {
        "type": "text",
        "store": false,
        "analyzer": "english_stop_analyzer",
        "search_analyzer": "english_stop_analyzer"
    }
  }
```

Basic attributes in *\_source* field aren't stored, because of sparing saving space.

```
"_source": {
    "enabled": false
},
```

## Development
  * git clone <url>
  * go to repository folder
  * python -m venv .\venv
  * .\venv\Scripts\activate
  * pip install -r requirements.txt
  * create your own mongo_db.env and es_indexer file in configs folder based on their examples
  * docker-compose up -d
  
Last command in Development section runs network with Elasticsearch, MongoDB, Kibana and our own container which connects through ssh MongoDB tunneling to our production database. After successfull connection it retrieves articles, which will be indexed in Elasticsearch and used for seeding local MongoDB.

## Deployment
After any commit / merge to the main branch, a github action is ran that builds the docker image for es_indexer and pushes it to dockerhub.  
  
## Test
  * cd ./test
  * python ./elastic_test.py # test Elasticsearch
  * python ./mongo_test.py # test MongoDB
