#!/bin/bash
set -e
set -u
source docker-config ${BASH_SOURCE[0]}

docker exec -it ${DOCKER_APP_NAME} bash
