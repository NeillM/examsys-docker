#!/usr/bin/env bash
set -e

echo rogo-compose.sh and will be removed in the future is deprecated please use examsys-compose.sh instead.

if [ ! -z "$ROGO_DOCKER_WWWROOT" ]
then
    echo ROGO_DOCKER_WWWROOT is deprecated. Please use EXAMSYS_DOCKER_WWWROOT instead.
    export EXAMSYS_DOCKER_WWWROOT="$ROGO_DOCKER_WWWROOT"
fi

if [ ! -z "$ROGO_DOCKER_MYSQLROOT" ]
then
    echo ROGO_DOCKER_MYSQLROOT is deprecated. Please use EXAMSYS_DOCKER_MYSQLROOT instead.
    export EXAMSYS_DOCKER_MYSQLROOT="$ROGO_DOCKER_MYSQLROOT"
fi

if [ ! -z "$ROGO_DOCKER_PHP" ]
then
    echo ROGO_DOCKER_PHP is deprecated. Please use EXAMSYS_DOCKER_PHP instead.
    export EXAMSYS_DOCKER_PHP="$ROGO_DOCKER_PHP"
fi

if [ ! -z "$ROGO_DOCKER_EXPOSE" ]
then
    echo ROGO_DOCKER_EXPOSE is deprecated. Please use EXAMSYS_DOCKER_EXPOSE instead.
    export EXAMSYS_DOCKER_EXPOSE="$ROGO_DOCKER_EXPOSE"
fi

if [ ! -z "$ROGO_DOCKER_WORKBENCH" ]
then
    echo ROGO_DOCKER_WORKBENCH is deprecated. Please use EXAMSYS_DOCKER_WORKBENCH instead.
    export EXAMSYS_DOCKER_WORKBENCH="$ROGO_DOCKER_WORKBENCH"
fi

if [ ! -z "$ROGO_DOCKER_WEB_HTTP_PORT" ]
then
    echo ROGO_DOCKER_WEB_HTTP_PORT is deprecated. Please use EXAMSYS_DOCKER_WEB_HTTP_PORT instead.
    export EXAMSYS_DOCKER_WEB_HTTP_PORT="$ROGO_DOCKER_WEB_HTTP_PORT"
fi

if [ ! -z "$ROGO_DOCKER_WEB_HTTPS_PORT" ]
then
    echo ROGO_DOCKER_WEB_HTTPS_PORT is deprecated. Please use EXAMSYS_DOCKER_WEB_HTTPS_PORT instead.
    export EXAMSYS_DOCKER_WEB_HTTPS_PORT="$ROGO_DOCKER_WEB_HTTPS_PORT"
fi

if [ ! -z "$ROGO_DOCKER_SELENIUM" ]
then
    echo ROGO_DOCKER_SELENIUM is deprecated. Please use EXAMSYS_DOCKER_SELENIUM instead.
    export EXAMSYS_DOCKER_SELENIUM="$ROGO_DOCKER_SELENIUM"
fi

if [ ! -z "$ROGO_DOCKER_SELENIUM_DEBUG" ]
then
    echo ROGO_DOCKER_SELENIUM_DEBUG is deprecated. Please use EXAMSYS_DOCKER_SELENIUM instead.
    export EXAMSYS_DOCKER_SELENIUM_DEBUG="$ROGO_DOCKER_SELENIUM_DEBUG"
fi

if [ ! -z "$ROGO_DOCKER_BROWSERSTACK" ]
then
    echo ROGO_DOCKER_BROWSERSTACK is deprecated. Please use EXAMSYS_DOCKER_BROWSERSTACK instead.
    export EXAMSYS_DOCKER_BROWSERSTACK="$ROGO_DOCKER_BROWSERSTACK"
fi

if [ ! -z "$ROGO_DOCKER_CLUSTER" ]
then
    echo ROGO_DOCKER_CLUSTER is deprecated. Please use EXAMSYS_DOCKER_CLUSTER instead.
    export EXAMSYS_DOCKER_CLUSTER="$ROGO_DOCKER_CLUSTER"
fi

if [ ! -z "$ROGO_DOCKER_MYSQLVERSION" ]
then
    echo ROGO_DOCKER_MYSQLVERSION is deprecated. Please use EXAMSYS_DOCKER_MYSQLVERSION instead.
    export EXAMSYS_DOCKER_MYSQLVERSION="$ROGO_DOCKER_MYSQLVERSION"
fi

if [ ! -z "$ROGO_DOCKER_MYSQLTZ" ]
then
    echo ROGO_DOCKER_MYSQLTZ is deprecated. Please use EXAMSYS_DOCKER_MYSQLTZ instead.
    export EXAMSYS_DOCKER_MYSQLTZ="$ROGO_DOCKER_MYSQLTZ"
fi

if [ ! -z "$ROGO_DOCKER_CLUSTERVERSION" ]
then
    echo ROGO_DOCKER_CLUSTERVERSION is deprecated. Please use EXAMSYS_DOCKER_CLUSTERVERSION instead.
    export EXAMSYS_DOCKER_CLUSTERVERSION="$ROGO_DOCKER_CLUSTERVERSION"
fi

if [ ! -z "$ROGO_DOCKER_INNODB_CLUSTER" ]
then
    echo ROGO_DOCKER_INNODB_CLUSTER is deprecated. Please use EXAMSYS_DOCKER_INNODB_CLUSTER instead.
    export EXAMSYS_DOCKER_INNODB_CLUSTER="$ROGO_DOCKER_INNODB_CLUSTER"
fi

if [ ! -z "$ROGO_DOCKER_MYSQL_PORT" ];
then
    echo ROGO_DOCKER_MYSQL_PORT is deprecated. Please use EXAMSYS_DOCKER_MYSQL_PORT instead.
    export EXAMSYS_DOCKER_MYSQL_PORT="$ROGO_DOCKER_MYSQL_PORT"
fi

if [ ! -z "$ROGO_DOCKER_MYSQL_USER" ];
then
    echo ROGO_DOCKER_MYSQL_USER is deprecated. Please use EXAMSYS_DOCKER_MYSQL_USER instead.
    export EXAMSYS_DOCKER_MYSQL_USER="$ROGO_DOCKER_MYSQL_USER"
fi

if [ ! -z "$ROGO_DOCKER_MYSQL_ROUTERVERSION" ]
then
    echo ROGO_DOCKER_MYSQL_ROUTERVERSION is deprecated. Please use EXAMSYS_DOCKER_MYSQL_ROUTERVERSION instead.
    export EXAMSYS_DOCKER_MYSQL_ROUTERVERSION="$ROGO_DOCKER_MYSQL_ROUTERVERSION"
fi

if [ ! -z "$ROGO_MEMCACHED" ]
then
    echo ROGO_MEMCACHED is deprecated. Please use EXAMSYS_DOCKER_WWWROOT instead.
    export EXAMSYS_DOCKER_MEMCACHED="$ROGO_MEMCACHED"
fi

if [ ! -z "$ROGO_RSERVE" ]
then
    echo ROGO_RSERVE is deprecated. Please use EXAMSYS_DOCKER_RSERVE instead.
    export EXAMSYS_DOCKER_RSERVE="$ROGO_RSERVE"
fi

if [ ! -z "$ROGO_MAIL_PORT" ]
then
    echo ROGO_MAIL_PORT is deprecated. Please use EXAMSYS_DOCKER_MAIL_PORT instead.
    export EXAMSYS_DOCKER_MAIL_PORT="$ROGO_MAIL_PORT"
fi

./examsys-compose.sh "$@"

echo rogo-compose.sh is deprecated and will be removed in the future please use examsys-compose.sh instead.
