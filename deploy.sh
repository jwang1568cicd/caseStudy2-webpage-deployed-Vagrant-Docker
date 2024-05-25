
#!/bin/bash

# Variable Declaration based on assumption that
# only 1 webimag and 1 container.
IMG="webimg2108"
DOCKERID=$(docker ps -a -q)
CONTAINER_NAME="web2108"

#
# Using docker to build and deploy $IMG
#
echo "########################################"

echo "Build image:" $IMG

echo "########################################"


docker build -t $IMG .

if [ $? -ne 0 ]; then
    echo "Error: Failed to build " $IMG
    exit 1
fi

#
# Removed container launched previously.
#
docker rm -f $DOCKERID  2>&1 > /dev/null

echo "########################################"

echo "Deploy container" $CONTAINER_NAME
echo "  with image:" $IMG

echo "########################################"

docker run --name $CONTAINER_NAME -d -p 9980:80 $IMG

if [ $? -ne 0 ]; then
    echo "Error: Failed to deploy " $IMG
    exit 1
fi

docker ps
