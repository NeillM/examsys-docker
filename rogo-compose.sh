dockercompose="docker-compose -f docker-compose.yml"

if [ -z "$ROGO_DOCKER_EXPOSE" ];
then
    export ROGO_DOCKER_EXPOSE=0
else
    dockercompose="${dockercompose} -f expose.yml"
fi

$dockercompose up -d
