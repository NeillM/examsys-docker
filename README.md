# rogo-docker: Docker Containers for Rogo Developers

This repository contains Docker configuration aimed at Rogo developers to easily deploy a testing environment for Rogo.

This should not be used on a production environment.
## Prerequisites
* [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed

## Quick start

```bash
# Set up path to Rogo code
export ROGO_DOCKER_WWWROOT=/path/to/rogo/code
# Set up mysql root password
export ROGO_DOCKER_MYSQLROOT=password
# Expose web server ports
export ROGO_DOCKER_EXPOSE=1

# Start up containers
rogo-compose

# Shut down and destroy containers
docker-compose down
```

## Stop and restart containers

If you want to use your containers continuously for manual testing or development without starting them up from scratch everytime you use them, you can also just stop without destroying them. With this approach, you can restart your containers sometime later, they will keep their data and won't be destroyed completely until you run `docker-compose down`.

```bash
# Stop containers
docker-compose stop

# Restart containers
rogo-compose
```

## Environment variables

You can change the configuration of the docker images by setting various environment variables before calling `docker-compose up`.

| Environment Variable                      | Mandatory | Allowed values                        | Default value | Notes                                                                        |
|-------------------------------------------|-----------|---------------------------------------|---------------|------------------------------------------------------------------------------|
| `ROGO_DOCKER_WWWROOT`                     | yes       | path on your file system              | none          | The path to the Rogo codebase you intend to test                             |
| `ROGO_DOCKER_MYSQLROOT`                   | yes       | string                                | none          | The root password for your mysql database                                    |
| `ROGO_DOCKER_EXPOSE`                      | no        | 0/1                                   | 0             | 1 enables webserver port exposure                                            |

## Rogo Configuration

When installing rogo you should set `WebServer host` to the ip address of the `web` container (this is due to database grants having to be set at the IP level).

You can set the `Database host` using the mysql container name - `db`.

If you wish to use memcache for session handling you will need to edit `/usr/local/etc/php/conf.d/rogo.ini` with the following:

```
session.save_handler = memcached
session.save_path = "cache:11211"
```

If you wish to use Rserve as you maths engine you will need to change the following in the Rogo configuration screen:

| setting | value |
|---------|-------|
| cfg_calc_settings : host| calc |
| cfg_calc_settings : port |6311 |
| cfg_calc_settings : timeout| choose a time out in seconds |
| cfg_calc_type| Rrserve |