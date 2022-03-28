

To use cron functions in the backend server, locate the /backend/cron.js file. 
In the `setup()` function, create a new callback. 
The process will be loaded with the start of the server.

```
const setup = () => {
    // Runs every minute
    cron.schedule('* * * * *', function() {
        clearOldRefreshTokens()
        console.log("Token cleansing performed.")
    })
}
```
