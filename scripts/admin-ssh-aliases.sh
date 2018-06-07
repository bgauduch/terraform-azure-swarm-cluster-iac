#!/bin/bash

# retrieve arguments & echo values
MANAGERS_IP_LIST=$1
WORKER_IP_LIST=$2
ENV=$3

echo Managers IP list: $MANAGERS_IP_LIST
echo Worker IP list: $WORKER_IP_LIST
echo environment: $ENV

# constants
PATH_TO_MANAGER_PRIVATE_KEY="/home/azureuser/.ssh/azure-test-rsa"
PATH_TO_WORKER_PRIVATE_KEY=$PATH_TO_MANAGER_PRIVATE_KEY
BASH_ALIAS_FILE_PATH=~/.bash_aliases
SSH_ALIAS_PREFIX_MANAGER=man
SSH_ALIAS_PREFIX_WORKER=wkr

# create bash aliases files
touch $BASH_ALIAS_FILE_PATH

# function to append ssh aliases to bash aliases
function add_ssh_aliase {
    local alias_name=$1
    local ip_address=$2
    alias="alias $alias_name='ssh azureuser@$ip_address\ -i $PATH_TO_MANAGER_PRIVATE_KEY'"
    echo $alias >> ~/.bash_aliases
}

# build & add manager aliases
iter=0
for i in "${MANAGERS_IP_LIST[@]}"
do
    alias_name="$ENV-$SSH_ALIAS_PREFIX_MANAGER-$iter"
    echo "current manager alias: $alias_name"
    add_ssh_aliase $alias_name $i
    ((ITER++))
done

# build & add worker aliases
iter=0
for i in "${WORKER_IP_LIST[@]}"
do
    alias_name="$ENV-$SSH_ALIAS_PREFIX_WORKER-$iter"
    echo "current worker alias: $alias_name"
    add_ssh_aliase $alias_name $i
    ((ITER++))
done