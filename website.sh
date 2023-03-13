#!/bin/bash

## Functions ##
help ()
{
    echo "syntax: ${BASH_SOURCE[0]} start|stop <website>"
    echo "        ${BASH_SOURCE[0]} cleanup <retention_days>"
    exit 0
}

## Main ##
ACTION=$1
WEBSITE=$2
DOMAIN=${DOMAIN:-smarthosting.com}

case $ACTION in
start)
    [[ $2 ]] || help
    echo "Deploying $WEBSITE (http://$WEBSITE.$DOMAIN)"
    docker run -it -d \
        --name $WEBSITE \
        --network hosting \
        -e WORDPRESS_DB_HOST: db \
        -e WORDPRESS_DB_USER: common \
        -e WORDPRESS_DB_PASSWORD: ${DB_PASSWORD:-insecure} \
        -e WORDPRESS_DB_NAME: wp_$WEBSITE \
        -v $WEBSITE:/var/www/html
        wordpress
;;
stop)
    [[ $3 ]] || help
    echo "Removing $WEBSITE (http://$WEBSITE.$DOMAIN)"
    docker stop -t 1 ci-$COMMIT
;;
cleanup)
    [[ $2 ]] || help
    # TODO: Implement cleaning up unused containers, volumes, images older than X days 
;;
*) help ;;
esac


