# Development environment
---
[**Github repo**](https://github.com/FIIT-TEAM8/dev_environment)

---

## Quick start
It is important that you have WSL 2 ready and configured. Every command executed in this section **has to be executed inside linux filesystem.** I recommend opening a new wsl terminal and simply typing _cd ~_ to go into your linux home folder.

!!! warning "Everything beyond this point assumes that you are executing commands on your linux filesystem."

Clone the Github repository and _cd_ into it:
```
git clone https://github.com/FIIT-TEAM8/dev_environment && cd dev_environment
```
Create a python virtual environment (if _python3_ does not work try _python_), activate it and install dependencies:
```
python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt
```
Then run the main.py file **with superuser permissions:**
```
sudo python3 main.py
```
You will be prompted for a password for encrypted environmental variables used in our project. The password is located inside our Keepass password manager as **ENV variables for DEV ENVIRONMENT**. 

To start the dev environment, run these commads:
```
docker-compose --env-file ./local.env up -d
```
The services are available on your localhost:PORT. The ports used can be checked in the **docker-compose.yml** file you just ran, but they are the same values as our production environment.
  

This configuration will replicate our [**data_infrastructure**](https://github.com/FIIT-TEAM8/data_infrastructure), meaning you will have mongo, express, postgres and elastic configured and ready to go. Elastic runs on a single-node configuration with SSL configured. Login credentials can be found inside local.env file.

The encrypted file contained in dev_environment source repository contains credentials for our remote production infrastructure, values contained inside local.env file are not important and only refer to credentials that will be used on your local machine, therefore this file is not encrypted in version control.

### Pulling data from production database
Each time you run **docker-compose up**, **es_indexer** container with python script will wait by default 60 seconds for Elasticsearch and MongoDB containers to start.

When, the time passes, es_indexer connects to MongoDB articles collection on our production machine. It retrieves by default 100 articles (you can change this through **NUMBER_OF_ARTICLES** in es_indexer.env),
index them in your local Elasticsearch container and seed your local MongoDB with them. 


!!! tip "Indexing"
    To learn more about the way we perform indexing go to [Elasticsearch module](https://team08-21.studenti.fiit.stuba.sk/docu/modules/elasticsearch/)
