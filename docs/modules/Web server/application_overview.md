## Run Instructions

### DEVELOPMENT
To run the project in the development environment run:\
_(make sure you are in the **root** folder)_

`npm run dev`

**Alternatively** open the separate directories and run: 

*frontend*: `npm start`\
*backend*: `npm run dev`

### PRODUCTION
To deploy the project:\
_(make sure you are in the **root** folder)_

`npm run deploy`

**Alternatively** open the separate directories and run:

*frontend*: `npm run build`\
*backend*: `npm run deploy`


## Environment variables

### Overview

This is the default configuration used while developing the application or while running in production. 

| Variable Name | Default Value | Description |
| ------------- | ------------- | ----------- |
| REACT_APP_PORT  | `8080`  | Where the application can be reached _(sets for both backend and frontend)_ |
| IS_HTTPS  | `true` (production) \| `false` (else) | Communication protocol between frontend and backend |
| COOKIE_AGE | `1000 * 60 * 60 * 24 * 30` _(30 days)_ | Age of server defined cookies (in ms) |
| BUILD_PATH | `../frontend/build` | Where the build of the React app resides |
| DATA_API_HOST | `http://flask_server:5000` | Destination of data api calls |
| DEV_DATA_API_HOST | `https://localhost:5000/api` | Destination of data api calls when not in production |
| DATA_API_VERSION | `v3` | Which version of data api should the calls be forwarded to |
| PUBLIC_URL | `/ams` | Subroute on which the application resides _(sets for both backend and frontend)_ |
| USE_SERVER_PUBLIC_URL | `false` | Should the express server use the PUBLIC_URL (this is not needed if connecting to node_server via NGINX) |

### Development

Environment variables can be easily modified for frontend and backend separately in `./frontend/.env` and `./backend/.env` respectively. 
The frontend variables need to begin with _REACT\_APP\__, otherwise it won't be loaded into the react application. The variables in _.env_ files will be overwritten by outside declarations. 

#### Development _docker_ environment

These variables need to be changed:

| Name | Value | Note |
| ---- | ----- | ---- |
| PUBLIC_URL | `/ams` | The app can be accessed at `http://localhost://8080/ams` |
| USE_SERVER_PUBLIC_URL | `true` | |
| IS_HTTPS | `false` | This does not affect anything at the moment, but will in the future |
| DATA_API_HOST | `http://localhost:5000` | If the data api is not running in a container |

Alternative without subroutes (not recommended):

| Name | Value | Note |
| ---- | ----- | ---- |
| PUBLIC_URL | `/` | The app can be accessed at `http://localhost://8080/` |
| USE_SERVER_PUBLIC_URL | `false` |  |
| IS_HTTPS | `false` | |
| DATA_API_HOST | `http://flask_server:5000`| |

#### Examples: 

Running _(linux)_ `REACT_APP_PORT=4000 npm run dev` will overwrite the REACT_APP_PORT for both backend and frontend. The same should apply while declaring variables while running the app in a _Docker_ container.

However, if we want to set the variable using the _.env_ files, we need to modify the _.env_ fils in both _./frontend_ and _./backend_ folders.

**Important!:** _Do not store any secrets in the .env files, as they are stored in version control._

#### Useful variables for the app's development

| Name | Environment | Description | Use Examples |
| ---- | ----------- | ----------- | ------------ |
| NODE_ENV | Backend & Frontend | Usually set to `production` or `development`, set by npm scripts | `./backend/config.js`, `./frontend/src/Utils/APIConnector.js` |

### Production

Enironment variables set in production (in node.env):

| Name | Value |
| ---- | ----- |
| REACT_APP_PORT | `8080` |
| PUBLIC_URL | `/ams` |
| USE_SERVER_PUBLIC_URL | `false` |


