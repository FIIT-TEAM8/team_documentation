# Flask server

---
[**Github repo**](https://github.com/FIIT-TEAM8/flask_server)

---

We use python Flask for our API server. Server listens for HTTP requests on various routes on multiple versions. These routes are detailed in [routes documentation page.](routes.md)

## Development
  * git clone
  * go to repository folder
  * python -m venv .\venv
  * .\venv\Scripts\activate
  * pip install -r requirements.txt
  * create .env file inside the root of the directory

The .env file should contain all environmental variables that are being read by Flask. You can check our [docker-compose.yml](https://github.com/FIIT-TEAM8/service_infrastructure/blob/main/docker-compose.yml) file inside our service_infrastructure repository for env files that are being read by Flask, open those env files and simply copy-paste the variables to your local .env file. You can change the contents of these variables to point to a development environment running on your machine.

The entrypoint for this project is in the **app.py** file in the root of this repository. The rest of the code is inside the **api** folder. This also contains multiple versions of our API. Each version contains **api_settings.py** folder containing settings varables for configuration, as well as required environment variables. 

For versioning our API we use Flask blueprints. Inside every python file containing server routes, you have tu declare a blueprint variable with appropriate parameters. For a good example check **flask_server/api/v2/search_routes.py**, which contains routes for searching and fetching articles from database and elasticsearch. This blueprint than has to be imported in the entrypoint of our app, which is **app.py**.

To run flask server, simply run this command inside the content root:

```
python -m  flask run --host=0.0.0.0 --port=5000
```
