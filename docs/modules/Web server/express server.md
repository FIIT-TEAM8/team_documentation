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

| Variable Name | Default Value | Description |
| ------------- | ------------- | ----------- |
| PORT  | `8080`  | Where the application can be reached via the Express server |
| IS_HTTPS  | `true` (production) \| `false` (else) | Communication protocol between frontend and backend |
| COOKIE_AGE | `1000 * 60 * 60 * 24 * 30` _(30 days)_ | Age of server defined cookies (in ms) |
| BUILD_PATH | `../frontend/build` | Where the build of the React app resides |
| DATA_API_HOST | `http://flask_server:5000` | Destination of data api calls |
| DEV_DATA_API_HOST | `https://localhost:5000/api` | Destination of data api calls when not in production |
| DATA_API_VERSION | `v3` | Which version of data api should the calls be forwarded to |
| NODE_ENV | `production` \| `dev` | Set by npm scripts automatically _(should not be changed manually)_ |

### Development

While in development, environment variables can be changed by creating a .env file in ./backend, like `./backend/.env`. 
An alternative is setting the variables manually.
