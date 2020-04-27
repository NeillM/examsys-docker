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
# Web server http port on host
export ROGO_DOCKER_WEB_HTTP_PORT=80
# Web server https port on host
export ROGO_DOCKER_WEB_HTTPS_PORT=443
# Expose db port for remote access
export ROGO_DOCKER_WORKBENCH=0
# Build Selenium for behat testing
export ROGO_DOCKER_SELENIUM=0
# Build BrowserStack for behat testing
export ROGO_DOCKER_BROWSERSTACK=0
# Your BrowserStack API key
export BROWSERSTACK_LOCAL_KEY=key

# Start up containers
rogo-compose.sh up -d

# Shut down and destroy containers
rogo-compose.sh down
```

## Stop and restart containers

If you want to use your containers continuously for manual testing or development without starting them up from scratch everytime you use them, you can also just stop without destroying them. With this approach, you can restart your containers sometime later, they will keep their data and won't be destroyed completely until you run `docker-compose down`.

```bash
# Stop containers
rogo-compose.sh stop

# Restart containers
rogo-compose.sh start
```

## Environment variables

You can change the configuration of the docker images by setting various environment variables before calling `docker-compose up`.

| Environment Variable                      | Mandatory | Allowed values                        | Default value | Notes                                                                        |
|-------------------------------------------|-----------|---------------------------------------|---------------|------------------------------------------------------------------------------|
| `ROGO_DOCKER_WWWROOT`                     | yes       | path on your file system              | none          | The path to the Rogo codebase you intend to test                             |
| `ROGO_DOCKER_MYSQLROOT`                   | yes       | string                                | none          | The root password for your mysql database                                    |
| `ROGO_DOCKER_EXPOSE`                      | no        | 0/1                                   | 0             | 1 enables webserver port exposure                                            |
| `ROGO_DOCKER_WORKBENCH`                   | no        | 0/1                                   | 0             | 1 enables database port exposure                                             |
| `ROGO_DOCKER_WEB_HTTP_PORT`               | yes       | integer                               | 80            | Host http port for web server                                                |
| `ROGO_DOCKER_WEB_HTTPS_PORT`              | yes      | integer                               | 443           | Host https port for web server                                                |
| `ROGO_DOCKER_SELENIUM`                    | no        | 0/1                                   | 0             | 1 setup selenium                                                             |
| `ROGO_DOCKER_BROWSERSTACK`                | no        | 0/1                                   | 0             | 1 setup browserstack                                                         |
| `BROWSERSTACK_LOCAL_KEY`                  | no        | string                                | none          | Your browserstack API key                                                    |
| `ROGO_DOCKER_CLUSTER`                     | no        | 0/1                                   | 0             | 1 load cluster database configuration instead of default mysql               |
| `ROGO_DOCKER_MYSQLROOT_HOST`              | no        | ip address of web container           | none          | Required by cluster database to allow access                                 |
| `ROGO_DOCKER_MYSQLVERSION`                | yes       | version of mysql to deploy            | 5.7           | Required by mysql database                                                   |
| `ROGO_DOCKER_CLUSTERVERSION`              | yes       | version of cluster to deploy          | 7.5           | Required by cluster database                                                 |
| `SELENIUM_VERSION`                        | no        | version of selenium                   | 3.14          | Version of selenium                                                          |
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
