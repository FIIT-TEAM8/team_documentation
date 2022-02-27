# Development environment
---
[**Github repo**](https://github.com/FIIT-TEAM8/dev_environment)

---

## Quick start
It is important that you have WSL 2 ready and configured. Every command executed in this section **has to be executed inside linux filesystem.** I recommend opening a new wsl terminal and simply typing _cd ~_ to go into your linux home folder.

!!! warning "Everything beyond this point assumes that you are executing commands on your linux filesystem."

Clone the Github repository and _cd_ into it:
```
git clone https://github.com/FIIT-TEAM8/dev_environment && cd service_config
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
The services are available on your localhost:<PORT>. The ports used can be checked in the **docker-compose.yml** file you just ran, but they are the same values as our production environment.
  
## Configuration
