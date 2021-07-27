#!/usr/bin/env bash
set -e

if [ ! -d "$ROGO_DOCKER_WWWROOT" ]
then
    echo 'Error: $ROGO_DOCKER_WWWROOT is not set or not an existing directory'
    exit 1
fi

if [ -z "$ROGO_DOCKER_MYSQLROOT" ]
then
    echo 'Error: $ROGO_DOCKER_MYSQLROOT is not set'
    exit 1
fi

dockercompose="docker-compose -f docker-compose.yml"

if [ -z "$ROGO_DOCKER_MYSQLTZ" ]
then
    export ROGO_DOCKER_MYSQLTZ=UTC
fi

if [ -z "$ROGO_DOCKER_CLUSTER" ]
then
    export ROGO_DOCKER_CLUSTER=0
fi

if [ -z "$ROGO_DOCKER_INNODB_CLUSTER" ]
then
    export ROGO_DOCKER_INNODB_CLUSTER=0
fi

if [ "$ROGO_DOCKER_CLUSTER" == 1 ]
then
    if [ -z "$ROGO_DOCKER_MYSQLROOT_HOST" ]
    then
        echo 'Error: $ROGO_DOCKER_MYSQLROOT_HOST is not set'
        exit 1
    fi
    if [ -z "$ROGO_DOCKER_CLUSTERVERSION" ]
    then
        export ROGO_DOCKER_CLUSTERVERSION=7.5
    fi
    dockercompose="${dockercompose} -f cluster.yml"
elif [ "$ROGO_DOCKER_INNODB_CLUSTER" == 1 ]
then
    if [ -z "$ROGO_DOCKER_MYSQLROOT_HOST" ]
    then
        echo 'Error: $ROGO_DOCKER_MYSQLROOT_HOST is not set'
        exit 1
    fi
    if [ -z "$ROGO_DOCKER_MYSQL_ROUTERVERSION" ]
    then
        export ROGO_DOCKER_MYSQL_ROUTERVERSION=8.0
    fi
    if [ -z "$ROGO_DOCKER_MYSQL_PORT" ];
    then
        export ROGO_DOCKER_MYSQL_PORT=6446
    fi
    if [ -z "$ROGO_DOCKER_MYSQL_USER" ];
    then
        export ROGO_DOCKER_MYSQL_USER=root
    fi
    dockercompose="${dockercompose} -f innodb-cluster.yml"
else
    if [ -z "$ROGO_DOCKER_MYSQLVERSION" ]
    then
        export ROGO_DOCKER_MYSQLVERSION=5.7
    fi
    dockercompose="${dockercompose} -f db.yml"
fi

if [ -n "$ROGO_DOCKER_EXPOSE" ]
then
    if [ -z "$ROGO_DOCKER_WEB_HTTP_PORT" ]
    then
        export ROGO_DOCKER_WEB_HTTP_PORT=80
    fi

    if [ -z "$ROGO_DOCKER_WEB_HTTPS_PORT" ]
    then
        export ROGO_DOCKER_WEB_HTTPS_PORT=443
    fi
fi

if [ -z "$ROGO_DOCKER_WORKBENCH" ]
then
    export ROGO_DOCKER_WORKBENCH=0
fi

if [ -z "$ROGO_DOCKER_SELENIUM" ]
then
    export ROGO_DOCKER_SELENIUM=0
fi

if [ -z "$ROGO_DOCKER_BROWSERSTACK" ]
then
    export ROGO_DOCKER_BROWSERSTACK=0
fi

if [ "$ROGO_DOCKER_EXPOSE" == 1 ]
then
    dockercompose="${dockercompose} -f expose.yml"
fi

if [ "$ROGO_DOCKER_WORKBENCH" == 1 ]
then
    if [ "$ROGO_DOCKER_INNODB_CLUSTER" == 1 ]
    then
        dockercompose="${dockercompose} -f innodb-cluster-workbench.yml"
    else
        dockercompose="${dockercompose} -f workbench.yml"
    fi
fi

if [ "$ROGO_DOCKER_SELENIUM" == 1 ]
then
    if [ -z "$SELENIUM_VERSION" ];
    then
        export SELENIUM_VERSION=3.141.59
    fi
    dockercompose="${dockercompose} -f selenium.yml"
fi

if [ "$ROGO_DOCKER_BROWSERSTACK" == 1 ]
then
    dockercompose="${dockercompose} -f browserstack.yml"
fi

$dockercompose $@
