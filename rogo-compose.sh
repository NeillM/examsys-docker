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
