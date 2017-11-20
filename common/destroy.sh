#!/bin/bash
set -e
set -u
source docker-config ${BASH_SOURCE[0]}

docker stop ${DOCKER_APP_NAME}
docker rm ${DOCKER_APP_NAME}
