#!/bin/bash
set -e
set -u
source docker-config ${BASH_SOURCE[0]}

docker build -t ${DOCKER_IMAGE_NAME} --build-arg "${DOCKER_BUILD_ARGS}" .
