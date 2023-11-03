#!/usr/bin/env bash
set -e

if [ ! -d "$EXAMSYS_DOCKER_WWWROOT" ]
then
    echo 'Error: $EXAMSYS_DOCKER_WWWROOT is not set or not an existing directory'
    exit 1
fi

if [ -z "$EXAMSYS_DOCKER_MYSQLROOT" ]
then
    echo 'Error: $EXAMSYS_DOCKER_MYSQLROOT is not set'
    exit 1
fi

if [ -z "$EXAMSYS_DOCKER_NAME" ]
then
    export EXAMSYS_DOCKER_NAME=examsys-docker
fi

dockercompose="docker compose -p $EXAMSYS_DOCKER_NAME -f docker-compose.yml"

if [ -z "$EXAMSYS_DOCKER_MYSQLTZ" ]
then
    export EXAMSYS_DOCKER_MYSQLTZ=UTC
fi

if [ -z "$EXAMSYS_DOCKER_CLUSTER" ]
then
    export EXAMSYS_DOCKER_CLUSTER=0
fi

if [ -z "$EXAMSYS_DOCKER_INNODB_CLUSTER" ]
then
    export EXAMSYS_DOCKER_INNODB_CLUSTER=0
fi

if [ -z "$EXAMSYS_DOCKER_PHP" ]
then
    export EXAMSYS_DOCKER_PHP=8.1
fi

if [ -z "$EXAMSYS_DOCKER_MEMCACHED" ]
then
    export EXAMSYS_DOCKER_MEMCACHED=0
fi

if [ -z "$EXAMSYS_RSERVE" ]
then
    export EXAMSYS_RSERVE=1
fi

if [ -z "$EXAMSYS_DOCKER_MAIL_PORT" ]
then
    export EXAMSYS_DOCKER_MAIL_PORT=1080
fi

if [ "$EXAMSYS_DOCKER_CLUSTER" == 1 ]
then
    if [ -z "$EXAMSYS_DOCKER_CLUSTERVERSION" ]
    then
        export EXAMSYS_DOCKER_CLUSTERVERSION=7.5
    fi
    if [ -z "$EXAMSYS_DOCKER_MYSQL_PORT" ];
    then
        export EXAMSYS_DOCKER_MYSQL_PORT=3306
    fi
    dockercompose="${dockercompose} -f cluster.yml"
elif [ "$EXAMSYS_DOCKER_INNODB_CLUSTER" == 1 ]
then
    if [ -z "$EXAMSYS_DOCKER_MYSQLVERSION" ]
    then
        export EXAMSYS_DOCKER_MYSQLVERSION=8.0
    fi
    if [ -z "$EXAMSYS_DOCKER_MYSQL_ROUTERVERSION" ]
    then
        export EXAMSYS_DOCKER_MYSQL_ROUTERVERSION=8.0
    fi
    if [ -z "$EXAMSYS_DOCKER_MYSQL_PORT" ];
    then
        export EXAMSYS_DOCKER_MYSQL_PORT=6446
    fi
    if [ -z "$EXAMSYS_DOCKER_MYSQL_USER" ];
    then
        export EXAMSYS_DOCKER_MYSQL_USER=root
    fi
    dockercompose="${dockercompose} -f innodb-cluster.yml"
else
    if [ -z "$EXAMSYS_DOCKER_MYSQLVERSION" ]
    then
        export EXAMSYS_DOCKER_MYSQLVERSION=5.7
    fi
    if [ -z "$EXAMSYS_DOCKER_MYSQL_PORT" ];
    then
        export EXAMSYS_DOCKER_MYSQL_PORT=3306
    fi
    dockercompose="${dockercompose} -f db.yml"
fi

if [ -n "$EXAMSYS_DOCKER_EXPOSE" ]
then
    if [ -z "$EXAMSYS_DOCKER_WEB_HTTP_PORT" ]
    then
        export EXAMSYS_DOCKER_WEB_HTTP_PORT=80
    fi

    if [ -z "$EXAMSYS_DOCKER_WEB_HTTPS_PORT" ]
    then
        export EXAMSYS_DOCKER_WEB_HTTPS_PORT=443
    fi
fi

if [ -z "$EXAMSYS_DOCKER_WORKBENCH" ]
then
    export EXAMSYS_DOCKER_WORKBENCH=0
fi

if [ -z "$EXAMSYS_DOCKER_SELENIUM" ]
then
    export EXAMSYS_DOCKER_SELENIUM=0
fi

if [ -z "$EXAMSYS_DOCKER_BROWSERSTACK" ]
then
    export EXAMSYS_DOCKER_BROWSERSTACK=0
fi

if [ "$EXAMSYS_DOCKER_EXPOSE" == 1 ]
then
    dockercompose="${dockercompose} -f expose.yml"
fi

if [ "$EXAMSYS_DOCKER_MEMCACHED" == 1 ]
then
    dockercompose="${dockercompose} -f memcache.yml"
fi

if [ "$EXAMSYS_DOCKER_RSERVE" == 1 ]
then
    dockercompose="${dockercompose} -f rserve.yml"
fi

if [ "$EXAMSYS_DOCKER_WORKBENCH" == 1 ]
then
    if [ "$EXAMSYS_DOCKER_INNODB_CLUSTER" == 1 ]
    then
        dockercompose="${dockercompose} -f innodb-cluster-workbench.yml"
    else
        dockercompose="${dockercompose} -f workbench.yml"
    fi
fi

if [ "$EXAMSYS_DOCKER_SELENIUM" == 1 ]
then
    if [ -z "$SELENIUM_VERSION" ];
    then
        export SELENIUM_VERSION=3.141.59
    fi
    if [ -z "$EXAMSYS_DOCKER_SELENIUM_VNC_PORT" ]
    then
        dockercompose="${dockercompose} -f selenium.yml"
    else
        dockercompose="${dockercompose} -f selenium-debug.yml"
    fi
fi

if [ "$EXAMSYS_DOCKER_BROWSERSTACK" == 1 ]
then
    dockercompose="${dockercompose} -f browserstack.yml"
fi

if [ -d "$EXAMSYS_DOCKER_FAILDUMP" ]
then
  dockercompose="${dockercompose} -f faildump.yml"
fi

$dockercompose $@
