#!/bin/bash

/usr/local/bin/dockerd-entrypoint.sh &

echo "== Waiting for docker deamon =="
while ! nc -zv 127.0.0.1 2376 2>&1 | grep -q open; do
    sleep 1
done
echo "== Docker daemon ready =="

# Create hosting docker network
docker network create --attachable -o com.docker.network.driver.mtu=1450 hosting

# TODO: Deploy management services 
# - reverse proxy
# - dns server
# - elasticsearch
# - fliebeat
# - landing website

# Customize landing page
sed -i -e "s/%DOMAIN%/${DOMAIN:-smarthosting.com}/" /custom/index.html

sleep infinity
