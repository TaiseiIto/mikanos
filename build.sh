#!/bin/bash

image=$1
container=$2
vnc_port=$3
target=$4

# Build a docker image.
if [ -z "$(docker images --format {{.Repository}} | grep -x $image)" ]; then
	docker build --build-arg vnc_port=$vnc_port -t $image .
fi

# Create a docker conatiner.
if [ -z "$(docker ps -a --format {{.Names}} | grep -x $container)" ]; then
	docker create -i -t -p $vnc_port:$vnc_port --privileged --name $container $image /bin/bash
	docker start $container
	docker exec $container /bin/bash -c "cd /root/edk2 && ./build_boot_loader.sh"
	docker exec $container /bin/bash -c "cd /root/mikanos && ./build_mikanos.sh"
	docker stop $container
fi

# Attach the docker container.
docker cp $container:/root/mikanos/$4 $4

