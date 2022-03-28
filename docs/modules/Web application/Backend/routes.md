!!! warning "All routes are prefixed by _PUBLIC\_URL_ set by the environment (default is _/ams_). This prefix should not be used in calls from the frontend app."

/api
====
A standard **response** from the **_/api_** route is structured as a json with standardized fields:

| Field | Description |
| ----- | ----------- |
| ok | Defines the sucess of the request |
| msg | Optional message to the client (most likely specifying an error) |
| data | The main data payload |

```
{
  "ok": true
  "msg": "Example message"
  "data": {}
}
```
```
{
  "ok": false
  "msg": "Something went wrong"
}
```

/api subroutes
====

/data subroutes
----
`/api/data/*`

| URL | Method | URL Params | Data Params | Sample Call | Notes |
| --- | ------ | ---------- | ----------- | ----------- | ----- |
| / | `GET` | | | `/api/data` | Root route, all subroutes serve as forwards to the Data API |
| /search | `GET` | `version[optional]` | | `/api/data/search?q=Marian+Kocner&version=v3` | Accepts and forwards all the parameters of the /search query from the Data API |

`/api/user/*`

| URL | Method | URL Params | Data Params | Sample Call | Notes |
| --- | ------ | ---------- | ----------- | ----------- | ----- |
| /signup | `POST` | | `{ "username": "", "password": "" }` | `/api/user/signup` | Credentials validations needs to be performed by client. |
| /login | `POST` |  | `{"username": "", "password": "", "maxCookieAge": 86400}` | `/api/user/login` | _maxCookieAge_ is in seconds and refers to the time after which the user is automatically logged out. |
| /token | `GET` | | | | Refreshes the access token, given the refresh token is present. |
| /logout | `POST` | | | `/api/user/logout` | Deletes the given refresh token from the database. Cookies should be removed by client. |
