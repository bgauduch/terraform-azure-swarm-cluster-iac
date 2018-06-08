#!/bin/bash

# retrieve arguments & echo values
MANAGERS_IP_LIST=$1
WORKER_IP_LIST=$2
ENV=$3
USER_NAME=$4

echo Managers IP list: $MANAGERS_IP_LIST
echo Worker IP list: $WORKER_IP_LIST
echo environment: $ENV
echo user name: $USER_NAME

# constants
PATH_TO_MANAGER_PRIVATE_KEY="/home/${USER_NAME}/.ssh/azure-test-rsa"
PATH_TO_WORKER_PRIVATE_KEY=$PATH_TO_MANAGER_PRIVATE_KEY
BASH_ALIAS_FILE_PATH=~/.bash_aliases
SSH_ALIAS_PREFIX_MANAGER=man
SSH_ALIAS_PREFIX_WORKER=wkr

# make sure bash_aliases file exist
touch $BASH_ALIAS_FILE_PATH

# function to append ssh aliases to bash aliases
function add_ssh_aliase {
    local alias_name=$1
    local ip_address=$2
    alias="alias ${alias_name}='ssh -i $PATH_TO_MANAGER_PRIVATE_KEY ${USER_NAME}@${ip_address}\'"
    echo $alias >> ~/.bash_aliases
}

# build & add manager aliases
iter=0
for i in "${MANAGERS_IP_LIST[@]}"
do
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_MANAGER}-${iter}"
    add_ssh_aliase $alias_name $i
    ((ITER++))
done

# build & add worker aliases
iter=0
for i in "${WORKER_IP_LIST[@]}"
do
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_WORKER}-${iter}"
    add_ssh_aliase $alias_name $i
    ((ITER++))
done

# update rights on ssh key
sudo chmod 600 $PATH_TO_MANAGER_PRIVATE_KEY