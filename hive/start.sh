#!/bin/bash
set -e
set -u
source docker-config ${BASH_SOURCE[0]}

docker run -d -p ${DOCKER_APP_EXTERNAL_PORT}:${DOCKER_APP_INTERNAL_PORT} -p 50070:50070 --name ${DOCKER_APP_NAME} ${DOCKER_IMAGE_NAME}
