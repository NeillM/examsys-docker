# rogo-docker: Docker Containers for Rogo Developers

This repository contains Docker configuration aimed at Rogo developers to easily deploy a testing environment for Rogo.

## Prerequisites
* [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed

## Quick start

```bash
# Set up path to Rogo code
export ROGO_DOCKER_WWWROOT=/path/to/rogo/code
# Set up mysql root password
export ROGO_DOCKER_MYSQLROOT=password

# Start up containers
docker-compose up -d

# Shut down and destroy containers
docker-compose down
```

## Stop and restart containers

If you want to use your containers continuously for manual testing or development without starting them up from scratch everytime you use them, you can also just stop without destroying them. With this approach, you can restart your containers sometime later, they will keep their data and won't be destroyed completely until you run `docker-compose down`.

```bash
# Stop containers
docker-compose stop

# Restart containers
docker-compose start
```

## Environment variables

You can change the configuration of the docker images by setting various environment variables before calling `docker-compose up`.

| Environment Variable                      | Mandatory | Allowed values                        | Default value | Notes                                                                        |
|-------------------------------------------|-----------|---------------------------------------|---------------|------------------------------------------------------------------------------|
| `ROGO_DOCKER_WWWROOT`                     | yes       | path on your file system              | none          | The path to the Rogo codebase you intend to test                             |
| `ROGO_DOCKER_MYSQLROOT`                   | yes       | string                                | none          | The root password for your mysql database                                    |