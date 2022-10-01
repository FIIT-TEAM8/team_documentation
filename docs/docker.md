# Docker workflow
In this project, we aim to use containerization in as many parts of our code base as possible. All services currently present in this code base are deployed as containers. Services are made from one or more modules, and each module is present as a single docker container.

Modules are declared inside a **docker-compose** file. This file manages the whole ecosystem and we use it to controll the state of each module. This file is located inside a **docker-folder**, which contains all files neccessary for our operations. The docker-folder itself is located inside the home folder of user **fiitkar**.

## Containers
All container images are pulled from Dockerhub. Some modules are simply official images of popular software modified using only environmental variables (e.g Elasticsearch, NGINX) and some modules are custom build Docker images (e.g flask API server or application server). None of these images are built on the machine, every module using a custom image has a github repository containing the source code and a Dockerfile used to create the image. Using Github actions (CI/CD pipeline) we build a docker image on Github's servers, publish it to our Dockerhub account and after the image is published, another automated action refreshes the running service using the docker-compose file present on our machine. 

### Persistent data / volumes
Persistent data for containers is stored under the **/data** directory, which is a mounting point for a secondary HDD big enough to hold this data. To avoid absolute paths in our docker compose file, there is a _symlink_ file created in **docker-folder**, where our docker compose file sits. This symlink is referenced in docker-compose file and points to **/data** directory.

### Environmental variables
Each container is configured using various environmental variables. These can contain host addresses for other services such as databases, login credentials and other configuration data. These variables are stored in separate **.env** files stored inside **env** directory residing next to our docker compose file. 


Each service should have it's own .env file, however some .env files **should be shared** by multiple services. For example, when multiple services are connecting to the same databse using the same credentials, there is no reason to declare these variables in multiple files and make refactoring code hard. There should be 1 .env file created for such cases and referenced by multiple services in docker-compose file. 

!!! note "Existing example"

    Flask server (API) and scraper components both connect to mongoDB using the same credentials. They each have their separate .env files (flask.env and scraper.env),       but both use one common .env file - **mongo_connection.env**. This file contains connection URL, login credentials and other data required for mongoDB access. This       approach makes it easy to change this data when we decide to change login credentials or rename our database collections.

### Versioning
The docker-compose file controlling our infrastructure is versioned in [this](https://github.com/FIIT-TEAM8/infrastructure) repository. Along with this file there are also our **.env** files containing configuration parameters for each service. As these files can also contain passwords, the **tar.gz**
 is encrypted using **AES-256** standard. This was achieved by running **encrypt_env.sh** shell script and to decrypt this archive and prepare **env** directory for use, simply run the **decrypt_env.sh** script. Both scripts expect 1 positional argument: a password used to for encryption / decryption. The password used is contained in our keepass password vault. E.g:
 
To decrypt the archive, run:
```
./decrypt_env.sh password123
```
This will decrypt and extract **env** directory to the same level as the script itself.

To encrypt env directory and create new archive:
```
./encrypt_env.sh password123
```
This will compress and encrypt the **env** directory with it's contents and create **env.tar.gz.enc** on the same level as the script itself.

!!! warning "When to encrypt env directory and push it to Github"

    You almost never want to run the script for encrypting your env directory. The environmental values versioned on Github should be set to values working for our production server. If you change something inside env directory on your local machine when developing, **do not** push it to Github.
    
