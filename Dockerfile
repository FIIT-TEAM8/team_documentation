FROM python:3.9-alpine

WORKDIR /documentation

COPY site .

EXPOSE 8080

CMD [ "python", "-m", "http.server", "8080" ]


