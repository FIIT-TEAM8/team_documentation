# Elasticsearch

---
[**Github repo**](https://github.com/FIIT-TEAM8/elasticsearch_mongo)

---

Elasticsearch runs in Docker container.
Currently works with one shard and one replica.

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

This type of analyzer is used during indexing documents and querying results. Each document contains one field(with name 'text') and it's value isn't stored in shard and replica.

```
"text": {
    "type": "text",
    "store": false,
    "analyzer": "english_stop_analyzer",
    "search_analyzer": "english_stop_analyzer"
}
```

\_source attribute isn't stored too, because of sparing saving space.

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
