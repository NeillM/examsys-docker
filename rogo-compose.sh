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

if [ -z "$ROGO_DOCKER_EXPOSE" ];
then
    export ROGO_DOCKER_EXPOSE=0
fi

if [ "$ROGO_DOCKER_EXPOSE" == 1 ]
then
    dockercompose="${dockercompose} -f expose.yml"
fi

$dockercompose up -d
