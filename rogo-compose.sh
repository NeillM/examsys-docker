#!/usr/bin/env bash
set -e

if [ ! -d "$ROGO_DOCKER_WWWROOT" ];
then
    echo 'Error: $ROGO_DOCKER_WWWROOT is not set or not an existing directory'
    exit 1
fi

if [ -z "$ROGO_DOCKER_MYSQLROOT" ];
then
    echo 'Error: $ROGO_DOCKER_MYSQLROOT is not set'
    exit 1
fi

dockercompose="docker-compose -f docker-compose.yml"

if [ -z "$ROGO_DOCKER_CLUSTER" ];
then
    export ROGO_DOCKER_CLUSTER=0
fi

if [ "$ROGO_DOCKER_CLUSTER" == 1 ]
then
    if [ -z "$ROGO_DOCKER_MYSQLROOT_HOST" ];
    then
        echo 'Error: $ROGO_DOCKER_MYSQLROOT_HOST is not set'
        exit 1
    fi
    dockercompose="${dockercompose} -f cluster.yml"
else
    dockercompose="${dockercompose} -f db.yml"
fi

if [ -z "$ROGO_DOCKER_EXPOSE" ];
then
    export ROGO_DOCKER_EXPOSE=0
fi

if [ -z "$ROGO_DOCKER_WORKBENCH" ];
then
    export ROGO_DOCKER_WORKBENCH=0
fi

if [ -z "$ROGO_DOCKER_SELENIUM" ];
then
    export ROGO_DOCKER_SELENIUM=0
fi

if [ -z "$ROGO_DOCKER_BROWSERSTACK" ];
then
    export ROGO_DOCKER_BROWSERSTACK=0
fi

if [ "$ROGO_DOCKER_EXPOSE" == 1 ]
then
    dockercompose="${dockercompose} -f expose.yml"
fi

if [ "$ROGO_DOCKER_WORKBENCH" == 1 ]
then
    dockercompose="${dockercompose} -f workbench.yml"
fi

if [ "$ROGO_DOCKER_SELENIUM" == 1 ]
then
    dockercompose="${dockercompose} -f selenium.yml"
fi

if [ "$ROGO_DOCKER_BROWSERSTACK" == 1 ]
then
    dockercompose="${dockercompose} -f browserstack.yml"
fi

$dockercompose $@
