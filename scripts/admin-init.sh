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

# update rights on ssh key
sudo chmod 600 $PATH_TO_MANAGER_PRIVATE_KEY

# make sure bash_aliases file exist
touch $BASH_ALIAS_FILE_PATH

# add manager aliases and install docker on manager VMs
iter=0
for i in "${MANAGERS_IP_LIST[@]}"
do
    # build & save the current manager vm alias
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_MANAGER}-${iter}"
    ssh_args="-i $PATH_TO_MANAGER_PRIVATE_KEY ${USER_NAME}@${i}"
    alias="alias ${alias_name}='ssh ${ssh_args}'"
    echo $alias >> ~/.bash_aliases

    # send docker install script to current manager VM & execute it
    scp -oStrictHostKeyChecking=no -i $PATH_TO_MANAGER_PRIVATE_KEY /tmp/docker-install.sh ${USER_NAME}@${i}:/tmp/docker-install.sh
    ssh -oStrictHostKeyChecking=no $ssh_args 'chmod +x /tmp/docker-install.sh && /tmp/docker-install.sh'
    ((ITER++))
done

# add worker aliases & install dokcer on worker VMs
iter=0
for i in "${WORKER_IP_LIST[@]}"
do
    # build & save the current worker vm alias
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_WORKER}-${iter}"
    ssh_args="-i $PATH_TO_WORKER_PRIVATE_KEY ${USER_NAME}@${i}"
    alias="alias ${alias_name}='ssh ${ssh_args}'"
    echo $alias >> ~/.bash_aliases

    # send docker install script to current worker VM & execute it
    scp -oStrictHostKeyChecking=no -i $PATH_TO_WORKER_PRIVATE_KEY /tmp/docker-install.sh ${USER_NAME}@${i}:/tmp/docker-install.sh
    ssh -oStrictHostKeyChecking=no $ssh_args 'chmod +x /tmp/docker-install.sh && /tmp/docker-install.sh'
    ((ITER++))
done
