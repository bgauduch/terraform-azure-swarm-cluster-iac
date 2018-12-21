#!/bin/bash

ADVERTISE_ADDRESS=$1
NUMBER_OF_MANAGERS=$2
CURRENT_MANAGER_NUMBER=$3

# init swarm cluster
if [ "$NUMBER_OF_MANAGERS" -eq 1 ] || [ "$NUMBER_OF_MANAGERS" -gt 1 && "$CURRENT_MANAGER_NUMBER" -eq 0 ]; then
    docker swarm init --advertise-addr $ADVERTISE_ADDRESS
    docker swarm join-token manager -q > /temp/token_manager
    docker swarm join-token worker -q > /temp/token_worker
else
    # join swarm cluster
    #docker swarm join --token