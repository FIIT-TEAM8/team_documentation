# NGINX

NGINX allows multiple declarations of the server context because each instance is used to handle a different type of requests. 
This web server listens on two ports, 80 (HTTP) and 443 (HTTPS). If user requests acces to server at port 80, he will be 
redirected to port 443 (with the use of the HTTP response status code 301, which is used for permanent redirecting).

```
server {
    listen 80;
    server_name team08-21.studenti.fiit.stuba.sk;
    location / {
        return 301 https://$host$request_uri;
    }
    ...
}

server {
    listen 443 ssl;
    server_name team08-21.studenti.fiit.stuba.sk;
    ...
```

Server context contains multiple location contexts. The correct location is choosed by looking at the request URI 
(the portion of the request after the domain name). Default location (no request URI) is responsible for loading the team website. 
This happens under `root` and `index` directives, where `root` contains path to the html file and `index` contains its name. 
This section also handles caching, which is currently turned off.

```
location / {
                root /usr/share/nginx/html;
                index index.html;
                try_files $uri $uri/ @server;

                # kill cache?
                expires off;
                add_header Last-Modified $date_gmt;
                add_header Cache-Control 'no-store, no-cache';
                if_modified_since off;
                etag off;
                access_log off;
    }
```

NGINX handles static files, such as team website, while all the other requests (scraper, flask and node servers and so on) are handled by different 
proxied servers. `proxy_pass` forwards the requests to the server listening on the specified address which also includes a port.

```
    location /api/ {
        proxy_pass http://flask_server:5000/;
    }

    location /ams/ {
        proxy_pass http://node_server:8080/;
    }

    location /scraper/ {
        proxy_pass http://scraper:6800/;
    }
    ...
```
