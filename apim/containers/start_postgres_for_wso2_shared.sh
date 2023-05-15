#!/bin/bash

source ./config.conf

printf "\033[32m-----------------------------------------------------\033[39m\n"
printf "\033[32mPostgreSQL will be listing on port $POSTGRES_WSO2_SHARED_PORT on the host  \033[39m\n"
printf "\033[32m-----------------------------------------------------\033[39m\n"

podman run -d \
    --name $POSTGRES_WSO2_SHARED_HOST \
    --network=$PODMAN_NETWORK \
    -e POSTGRES_USER=$POSTGRES_WSO2_SHARED_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_WSO2_SHARED_PASSWORD \
    -e POSTGRES_DB=$POSTGRES_WSO2_SHARED_DB \
    -p $POSTGRES_WSO2_SHARED_PORT:5432 \
    postgres:15

podman logs -f $POSTGRES_WSO2_SHARED_HOST