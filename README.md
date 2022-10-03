# examsys-docker: Docker Containers for ExamSys Developers

This repository contains Docker configuration aimed at ExamSys developers to easily deploy a testing environment for ExamSys.

This should not be used on a production environment.
## Prerequisites
* [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed

Note: These scripts are not fully compatible with the docker-compose command using Docker Compose V2

## Quick start

```bash
# Set up path to ExamSys code
export EXAMSYS_DOCKER_WWWROOT=/path/to/examsys/code
# Set up mysql root password
export EXAMSYS_DOCKER_MYSQLROOT=password
# Expose web server ports
export EXAMSYS_DOCKER_EXPOSE=1
# Web server http port on host
export EXAMSYS_DOCKER_WEB_HTTP_PORT=80
# Web server https port on host
export EXAMSYS_DOCKER_WEB_HTTPS_PORT=443
# Expose db port for remote access
export EXAMSYS_DOCKER_WORKBENCH=0
# Build Selenium for behat testing
export EXAMSYS_DOCKER_SELENIUM=0
# Setup Selenium in debug mode
export EXAMSYS_DOCKER_SELENIUM_DEBUG=0
# Build BrowserStack for behat testing
export EXAMSYS_DOCKER_BROWSERSTACK=0
# Your BrowserStack API key
export BROWSERSTACK_LOCAL_KEY=key

# Start up containers
examsys-compose.sh up -d

# Shut down and destroy containers
examsys-compose.sh down
```

## Stop and restart containers

If you want to use your containers continuously for manual testing or development without starting them up from scratch everytime you use them, you can also just stop without destroying them. With this approach, you can restart your containers sometime later, they will keep their data and won't be destroyed completely until you run `docker-compose down`.

```bash
# Stop containers
examsys-compose.sh stop

# Restart containers
examsys-compose.sh start
```

## Environment variables

You can change the configuration of the docker images by setting various environment variables before calling `docker-compose up`.

| Environment Variable                 | Mandatory      | Allowed values                    | Default value | Notes                                            |
|--------------------------------------|----------------|-----------------------------------|---------------|--------------------------------------------------|
| `EXAMSYS_DOCKER_WWWROOT`             | yes            | path on your file system          | none          | The path to the Rogo codebase you intend to test |
| `EXAMSYS_DOCKER_MYSQLROOT`           | yes            | string                            | none          | The root password for your mysql database        |
| `EXAMSYS_DOCKER_PHP`                 | no             | latest, 7.4, 8.0, 8.1             | 7.4           | The version of PHP that should be used           |
| `EXAMSYS_DOCKER_EXPOSE`              | no             | 0/1                               | 0             | 1 enables webserver port exposure                |
| `EXAMSYS_DOCKER_WORKBENCH`           | no             | 0/1                               | 0             | 1 enables database port exposure                 |
| `EXAMSYS_DOCKER_WEB_HTTP_PORT`       | yes            | integer                           | 80            | Host http port for web server                    |
| `EXAMSYS_DOCKER_WEB_HTTPS_PORT`      | yes            | integer                           | 443           | Host https port for web server                   |
| `EXAMSYS_DOCKER_SELENIUM`            | no             | 0/1                               | 0             | 1 setup selenium                                 |
| `EXAMSYS_DOCKER_SELENIUM_DEBUG`      | no             | 0/1                               | 0             | 1 debug mode                                     |
| `EXAMSYS_DOCKER_BROWSERSTACK`        | no             | 0/1                               | 0             | 1 setup browserstack                             |
| `BROWSERSTACK_LOCAL_KEY`             | no             | string                            | none          | Your browserstack API key                        |
| `EXAMSYS_DOCKER_CLUSTER`             | ndb cluster    | 0/1                               | 0             | 1 load cluster database configuration            |
| `EXAMSYS_DOCKER_MYSQLVERSION`        | yes            | version of mysql to deploy        | latest        | Required by mysql database                       |
| `EXAMSYS_DOCKER_MYSQLTZ`             | yes            | default timezone of db            | UTC           | This to be set to the same as the web service    |
| `EXAMSYS_DOCKER_CLUSTERVERSION`      | ndb cluster    | version of cluster to deploy      | 7.5           | Required by cluster database                     |
| `SELENIUM_VERSION`                   | no             | version of selenium               | 3.14          | Version of selenium                              |
| `EXAMSYS_DOCKER_INNODB_CLUSTER`      | innodb cluster | 0/1                               | 0             | 1 load innodb cluster database configuration     |
| `EXAMSYS_DOCKER_MYSQL_PORT`          | no             | integer                           | 3306/6446     | port that mysql workbench can use to connect     |
| `EXAMSYS_DOCKER_MYSQL_USER`          | innodb cluster | string                            | root          | user used to connect to servers                  |
| `EXAMSYS_DOCKER_MYSQL_ROUTERVERSION` | innodb cluster | version of mysql router to deploy | 8.0           | Required by mysql router                         |
| `EXAMSYS_DOCKER_MEMCACHED`           | no             | 0/1                               | 0             | Enables memcached sessions in PHP                |
| `EXAMSYS_DOCKER_RSERVE`              | no             | 0/1                               | 1             | Starts rserve                                    |
| `EXAMSYS_DOCKER_MAIL_PORT`           | no             | integer                           | 1080          | The port that the mail server will be exposed on |

## Installing ExamSys

Create a settings.xml file in the config directory of ExamSys, you can use an example file from this repository, for example settings-innodb.xml.

To ensure that there are no database connection errors when the hosts are started and stopped the settings/server/host value can be set as % this will ensure that the ExamSys database users can connect to the database from any server (you should not do this on a production server).

If installing from the git repository you will need to run the following commands:

```bash
examsys-compose.sh exec -T web npm install
examsys-compose.sh exec -T web grunt
```

Now you can install ExamSys using the following command:

```bash
examsys-compose.sh exec -T web php cli/init.php -u root -p $EXAMSYS_DOCKER_MYSQLROOT -s db -t 3306 -n examsys
```

If you wish to do automatic testing of ExamSys you must install it directly from the git repository, since the community releases do not include the testing code.

### Phpunit

To initialise phpunit you will need to create a phpunit.xml file in the config directory, you can use an example file from this repository as a base for this phpunit-innodb.xml (The database password in it will need modifying)

After installing ExamSys you will now be able to initialise the phpunit database using:

```bash
examsys-compose.sh exec -T web php testing/unittest/cli/init.php
```

### Behat

To initialise phpunit you will need to create a behat.xml file in the config directory, you can use an example file from this repository as a base for this behat-innodb.xml (The database password in it will need modifying)

After installing ExamSys you will be able to initialise the phpunit database using:

```bash
examsys-compose.sh exec -T web php testing/behat/cli/init.php
```

### Rserve

If you wish to use Rserve as your maths engine you will need to change the following in the ExamSys configuration screen:

| setting                     | value                        |
|-----------------------------|------------------------------|
| cfg_calc_settings : host    | calc                         |
| cfg_calc_settings : port    | 6311                         |
| cfg_calc_settings : timeout | choose a time out in seconds |
| cfg_calc_type               | Rrserve                      |

### Email

Emails are not enabled by default in the docker image. However, you can set ExamSys up to use Mail Catcher as its SMTP server.

You will need to change the following in the ExamSys configuration screen:

| setting     | value |
|-------------|-------|
| mailer_host | mail  |
| mailer_port | 1025  |

The web interface to inspect the emails sent by ExamSys is exposed on port 1080

## Also see

* [examsys-php-apache](https://bitbucket.org/examsys/examsys-php-apache)
