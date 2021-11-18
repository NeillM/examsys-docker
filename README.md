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
# Setup Selenium in debug mode
export ROGO_DOCKER_SELENIUM_DEBUG=0
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

| Environment Variable                      | Mandatory          | Allowed values                   | Default value | Notes                                                                        |
|-------------------------------------------|--------------------|----------------------------------|---------------|------------------------------------------------------------------------------|
| `ROGO_DOCKER_WWWROOT`                     | yes                | path on your file system         | none          | The path to the Rogo codebase you intend to test                             |
| `ROGO_DOCKER_MYSQLROOT`                   | yes                | string                           | none          | The root password for your mysql database                                    |
| `ROGO_DOCKER_EXPOSE`                      | no                 | 0/1                              | 0             | 1 enables webserver port exposure                                            |
| `ROGO_DOCKER_WORKBENCH`                   | no                 | 0/1                              | 0             | 1 enables database port exposure                                             |
| `ROGO_DOCKER_WEB_HTTP_PORT`               | yes                | integer                          | 80            | Host http port for web server                                                |
| `ROGO_DOCKER_WEB_HTTPS_PORT`              | yes                | integer                          | 443           | Host https port for web server                                               |
| `ROGO_DOCKER_SELENIUM`                    | no                 | 0/1                              | 0             | 1 setup selenium                                                             |
| `ROGO_DOCKER_SELENIUM_DEBUG`              | no                 | 0/1                              | 0             | 1 debug mode                                                            |
| `ROGO_DOCKER_BROWSERSTACK`                | no                 | 0/1                              | 0             | 1 setup browserstack                                                         |
| `BROWSERSTACK_LOCAL_KEY`                  | no                 | string                           | none          | Your browserstack API key                                                    |
| `ROGO_DOCKER_CLUSTER`                     | ndb cluster        | 0/1                              | 0             | 1 load cluster database configuration                                        |
| `ROGO_DOCKER_MYSQLROOT_HOST`              | ndb/innodb cluster | ip address of web container      | none          | Required by cluster databases to allow designated IP access                  |
| `ROGO_DOCKER_MYSQLVERSION`                | yes                | version of mysql to deploy       | latest        | Required by mysql database                                                   |
| `ROGO_DOCKER_MYSQLTZ`                     | yes                | default timezone of db           | UTC           | This to be set to the same as the web service                                |
| `ROGO_DOCKER_CLUSTERVERSION`              | ndb cluster        | version of cluster to deploy     | 7.5           | Required by cluster database                                                 |
| `SELENIUM_VERSION`                        | no                 | version of selenium              | 3.14          | Version of selenium                                                          |
| `ROGO_DOCKER_INNODB_CLUSTER`              | innodb cluster     | 0/1                              | 0             | 1 load innodb cluster database configuration                                 |
| `ROGO_DOCKER_MYSQL_PORT`                  | innodb cluster     | integer                          | 6446          | port the mysql server is using                                               |
| `ROGO_DOCKER_MYSQL_USER`                  | innodb cluster     | string                           | root          | user used to connect to servers                                              |
| `ROGO_DOCKER_MYSQL_ROUTERVERSION`         | innodb cluster     | version of mysql router to depoy | 8.0           | Required by mysql router                                                     |
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

### Email

Emails are not enabled by default in the docker image. However, you can set Rogo up to use Mail Catcher as its SMTP server.

You will need to change the following in the Rogo configuration screen:

| setting | value |
|---------|-------|
| mailer_host | mail |
| mailer_port | 1025 |

The web interface to inspect the emails sent by Rogo is exposed on port 1080
