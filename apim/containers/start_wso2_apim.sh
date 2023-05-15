#!/bin/bash

source ./config.conf

podman run \
    -d \
    --name $WSO2_APIM_HOST \
    --network=$PODMAN_NETWORK \
    -p 8243:8243 \
    -p 9443:9443 \
    jarry/wso2-apim:4.2.0