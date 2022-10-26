
---
[**Frontend Github repo**](https://github.com/FIIT-TEAM8/frontend)

---


---
[**Node_server Github repo**](https://github.com/FIIT-TEAM8/node_server)

---

## Set up
* I recommend creating new folder in root directory of WSL2: `mkdir <folder_name>`
* `cd <folder_name>`
* `git clone https://github.com/FIIT-TEAM8/frontend.git`
* `cd ./frontend && npm install && cd ..`
* `git clone https://github.com/FIIT-TEAM8/node_server.git`
* `cd ./node_server && npm install && cd ..`

Thanks to previous steps we have cloned all required repositories and installed their dependencies.
However our *node_server* uses PostreSQL. Because of that, we are going to create a *docker-compose.yaml*, which runs
an instance of this database in a container on our local machine.

* Open VS Code in directory, which we have created in first step of this set up (`code .` in that directory)
* In VS Code create new file with name `docker-compose.yaml`
* Paste following lines of codes in `docker-compose.yaml`

```
version: '3'
services:
  postgres_db:
    image: fiitteam8/postgres_db:latest
    container_name: postgres_db
    env_file:
      - ../node_server/.env
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - 5432:5432
      
volumes:
  postgres_data:
```

## How to run

Before running the following commands, make sure you have finished **Set up** chapter and your location in console is in a directory, which contains frontend and node_server repositories.
To start node_server, with required database, paste the following commands in console:

* `docker-compose up -d`
* `cd ./node_server && npm run dev`

To start frontend paste the following command in console:

* `cd ./frontend && npm run start`

## Some Notes

!!! warning "Never ever delete **.env** or **env.sh** from frontend repository."

Thanks to this files we are creating **env-config.js** during docker image build. **env-config.js** is imported in index.html, which allows injecting env variables in production after image build. If you want to learn more I recommend this [tutorial](https://www.freecodecamp.org/news/how-to-implement-runtime-environment-variables-with-create-react-app-docker-and-nginx-7f9d42a91d70/)
