# Docker workflow
In this project, we aim to use containerization in as many parts of our code base as possible. All services currently present in this code base are deployed as containers. Services are made from one or more modules, and each module is present as a single docker container.

Modules are declared inside a **docker-compose** file. This file manages the whole ecosystem and we use it to controll the state of each module.

## Containers
All containers are pulled from Dockerhub. Some modules are simply official images of popular software modified using only environmental variables (e.g Elasticsearch, NGINX) and some modules are custom build Docker images (e.g flask API server or application server). None of these images are built on the machine, every module using a custom image has a github repository containing the source code and a Dockerfile used to create the image. Using Github actions (CI/CD pipeline) we build a docker image on Github's servers, publish it to our Dockerhub account and after the image is published, another automated action refreshes the running service using the docker-compose file present on our machine. 
