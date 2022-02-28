# Development environment
---
[**Github repo**](https://github.com/FIIT-TEAM8/dev_environment)

---

## Quick start
It is important that you have WSL 2 ready and configured. Every command executed in this section **has to be executed inside linux filesystem.** I recommend opening a new wsl terminal and simply typing _cd ~_ to go into your linux home folder.

!!! warning "Everything beyond this point assumes that you are executing commands on your linux filesystem."

Clone the Github repository and _cd_ into it:
```
git clone https://github.com/FIIT-TEAM8/dev_environment && cd dev_environment
```
Create a python virtual environment (if _python3_ does not work try _python_), activate it and install dependencies:
```
python3 -m venv venv
```
```
source venv/bin/activate
```
```
pip install -r requirements.txt
```
Then run the main.py file **with superuser permissions:**
```
sudo python3 main.py
```
You will be prompted for a password for encrypted environmental variables used in our project. The password is located inside our Keepass password manager as **ENV variables config tar key**. The default configuration for virtual environment **excludes a few of our components** for performance reasons. These services are listed in the **config.yaml** file located next to **main.py** file under the **redundant_services**. This file and all configuration options for this dev environment are explained in the next section of this documentation.

To start the dev environment, run these commads:
```
cd service_config
```
```
docker-compose up -d
```
The services are available on your localhost:PORT. The ports used can be checked in the **docker-compose.yml** file you just ran, but they are the same values as our production environment.
  
## Configuration
The dev_environment repository comes with a **config.yaml** file that can be used to change the behaviour of your development environment. 


!!! warning "Anytime you change config.yaml you have to **re-run main.py and docker-compose** to see these changes"

### redundant_services
The first key option is **redundant_services**. This is a list of services that will be **deleted** from **docker-compose.yml** and thus won't run in your dev environment. These are by default services like our documentation server or certbot, but **here you can specify a service that you want to work on**. For example, if you want to develop scraper, include it in this list and the scraper component will not be created as a container.

### service_details
This is a section containing details about our services. A service name is a key to another subsection, where options for that service are present.


Anything under the **compose_adjustment** subsection should be a valid **docker-compose.yml** service configuration values. Here you can adjust what will be added to services in docker-compose.yml when you run **main.py** script. For example, if you want to add ports configuration to scraper service, your config.yaml should look like this:

```yaml
...
service_details:
  scraper:
    compose_adjustment:
      ports:
        - 6800:6800 
...
```
If the key specified in **compose_adjustment** already exists in docker-compose.yml, it will override the value if it is a simple key-value pair and append to list if it is a list.

The default config.yaml contains some compose_adjustments that you can look at for another example:
```yaml
...
service_details:
  es01:
    compose_adjustment:
      environment:
        - "discovery.type=single-node"
...
```
This will append **discovery.type=single-node** to env variables for es01 service. In this case, it is required because on windows, docker does not allow dot-notation in .env files, where this variable is specified on our production environment. 

!!! tip "Fun fact / tip"
    Environment variables declared in **environment** section in **docker-compose.yml** will override variables with the same name declared in .env file that is included in docker-compose.yml. That means that you can use **config.yaml** to override environmental variables used in our production environment.

