PLATFORM="boneblack"
# Development specific variables
DOCKER_COMPOSE_FILE=${PWD}/Docker/docker-compose.yml
SERVICE_NAME=${PLATFORM}-development

# Username of hte image
IMAGE_NAME=${SERVICE_NAME}-${USER}:latest


# Bash way of printing help message
help()
{
cat << EOF
Usage: $0 <command>

where <command> is one of:
	develop:	Use an already constructed docker container
	create: 	Create a new docker container for use
	help:		Display the help message
EOF
}

if [ -r ${HOME}/.stonefly-dev/docker-compose.override.yml ]; then
    DOCKER_COMPOSE_OVERRIDE="-f ${HOME}/.stonefly-dev/docker-compose.override.yml";
else
    unset DOCKER_COMPOSE_OVERRIDE
fi

# No way one can override the current docker file
# Store the argument passed in variable "cmd"

cmd=$1
case $cmd in
	create)
		COMPOSE_DOCKER_CLI_BUILD=1  IMAGE_NAME=${IMAGE_NAME}  docker-compose -f ${DOCKER_COMPOSE_FILE} build
		;;
	develop)
		shift
		COMPOSE_DOCKER_CLI_BUILD=1 IMAGE_NAME=${IMAGE_NAME}  docker-compose -f ${DOCKER_COMPOSE_FILE} ${DOCKER_FILE_OVERRIDE} run --rm ${SERVICE_NAME} $@
		;;
	*)
		help
		exit 1
		;;
esac
