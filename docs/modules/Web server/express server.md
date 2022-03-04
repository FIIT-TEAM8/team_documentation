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

| Variable Name | Default Value | Description |
| ------------- | ------------- | ----------- |
| PORT  | 8080  | Where the application can be reached via the Express server |
| IS_HTTPS  | _true_ (production) \| _false_ (else) | Communication protocol between frontend and backend |
| COOKIE_AGE | 1000 * 60 * 60 * 24 * 30 _(30 days)_ | Age of server defined cookies (in ms) |
| BUILD_PATH | '../frontend/build' | Where the build of the React app resides |
| API_HOST | 'http://flask_server:5000/v3' | Destination of data api calls |
| DEV_API_HOST | 'https://localhost:5000/api/v3' | Destination of data api calls when not in production |
| NODE_ENV | 'production'/'dev' | Set by starting scripts automatically |

