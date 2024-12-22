#!/bin/bash

image=$1
container=$2

# Build a docker image.
if [ -z "$(docker images --format {{.Repository}} | grep -x $image)" ]; then
	docker build -t $image .
fi

# Create a docker conatiner.
if [ -z "$(docker ps -a --format {{.Names}} | grep -x $container)" ]; then
	docker create -i -t --privileged --name $container $image /bin/bash
fi

# Start the docker container.
if [ -z "$(docker ps --format {{.Names}} | grep -x $container)" ]; then
	docker start $container
fi

# Attach the docker container.
docker attach $container

