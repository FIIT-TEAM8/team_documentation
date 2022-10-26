## Environment variables

### Overview

This is the default configuration used while developing the application or while running in production. 

#### Node_server

| Variable Name | Default Value | Description |
| ------------- | ------------- | ----------- |
| APP_PORT  | `8080`  | Where the application can be reached _(sets for both backend and frontend)_ |
| IS_HTTPS  | `true` (production) \| `false` (else) | Communication protocol between frontend and backend |
| COOKIE_AGE | `1000 * 60 * 60 * 24 * 30` _(30 days)_ | Age of server defined cookies (in ms) |
| AUTH_COOKIE_AGE | `1000 * 60 * 2` _(2 minutes)_ | Ask David |
| DATA_API_HOST | `http://flask_server:5000` | Destination of data api calls |
| DEV_DATA_API_HOST | `https://localhost:5000/api` | Destination of data api calls when not in production |
| DATA_API_HOST | `http://flask_server:5000` | Destination of data api calls in production |
| DATA_API_VERSION | `v3` | Which version of data api should the calls be forwarded to |
| POSTGRES_USER | `postgres` | Username |
| POSTGRES_PASSWORD | `postgres` | Password |
| POSTGRES_DB | `ams` | Name of the database, which contains all tables |
| POSTGRES_HOST | `localhost` | DB is hosted on this host |
| POSTGRES_PORT | `5432` | DB listen on this port |

#### Frontend
| Variable Name | Default Value | Description |
| ------------- | ------------- | ----------- |
| REACT_APP_NODE_SERVER_URL | `http://localhost:8080` | Makes requests on this URL from browser, when getting data |

### Development

Environment variables can be easily modified for frontend and node_server separately in thier *.env* files. 
The frontend variables need to begin with _REACT\_APP\__, otherwise it won't be loaded into the react application. The variables in _.env_ files will be overwritten by outside declarations. 

!!! warning "**Important!:** _Do not store any secrets in the .env files, as they are stored in version control._"

#### Useful variables for the app's development

| Name | Environment | Description | Use Examples |
| ---- | ----------- | ----------- | ------------ |
| NODE_ENV | Node_server & Frontend | Usually set to `production` or `development`. `production` set in Dockerfiles | `./node_server/config.js`, `./frontend/src/Utils/APIConnector.js` |
