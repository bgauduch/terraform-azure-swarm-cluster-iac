#!/bin/bash

# retrieve arguments & echo values
MANAGERS_FQDN_LIST=$1
WORKER_FQDN_LIST=$2
ENV=$3

echo Managers FQDN list: $MANAGERS_FQDN_LIST
echo Worker FQDN list: $WORKER_FQDN_LIST
echo environment: $ENV

# constants
PATH_TO_MANAGER_PRIVATE_KEY=/home/azureuser/.ssh/authorized_keys
PATH_TO_WORKER_PRIVATE_KEY=$PATH_TO_MANAGER_PRIVATE_KEY
BASH_ALIAS_FILE_PATH=~/.bash_aliases
SSH_ALIAS_PREFIX_MANAGER=man
SSH_ALIAS_PREFIX_WORKER=wkr

# create bash aliases files
touch $BASH_ALIAS_FILE_PATH

# build & add manager aliases
for i in "${MANAGERS_FQDN_LIST[@]}"
do
    echo "$i"
    alias_name="$ENV_$SSH_ALIAS_PREFIX_MANAGER_$i"
    add_ssh_aliase $alias_name $WORKER_FQDN_LIST[$i]
done

# build & add worker aliases
for i in "${WORKER_FQDN_LIST[@]}"
do
    echo "$i"
    alias_name="$ENV_$SSH_ALIAS_PREFIX_WORKER_$i"
    add_ssh_aliase $alias_name $WORKER_FQDN_LIST[$i]
done


function add_ssh_aliase() {
    alias_name=$1
    fqdn_address=$2
    echo "alias $alias_name= \'ssh azureuser@fqdn_address\'" >> ~/.bash_aliases
}