#!/bin/bash

# retrieve arguments
MANAGERS_IP_LIST_STRING=$1
WORKER_IP_LIST_STRING=$2
ENV=$3
USER_NAME=$4

# parse ip list
IFS=',' read -ra MANAGERS_IP_LIST <<< "$MANAGERS_IP_LIST_STRING"
IFS=',' read -ra WORKER_IP_LIST <<< "$WORKER_IP_LIST_STRING"

# display script values
echo Managers IP list: "${MANAGERS_IP_LIST[*]}"
echo Worker IP list: "${WORKER_IP_LIST[*]}"
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
iter=1
for i in "${MANAGERS_IP_LIST[@]}"
do
    # build & save the current manager vm alias
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_MANAGER}-${iter}"
    ssh_args="-i $PATH_TO_MANAGER_PRIVATE_KEY ${USER_NAME}@${i}"
    alias="alias ${alias_name}='ssh ${ssh_args}'"
    echo $alias >> ~/.bash_aliases

    # send vm init script to current manager VM & execute it
    scp -oStrictHostKeyChecking=no -i $PATH_TO_MANAGER_PRIVATE_KEY /tmp/vm-init.sh ${USER_NAME}@${i}:/tmp/vm-init.sh
    ssh -oStrictHostKeyChecking=no $ssh_args "nohup sh -c 'chmod +x /tmp/vm-init.sh && /tmp/vm-init.sh' > /tmp/vm-init.log 2>&1 &"

    ((iter++))
done

# add worker aliases & install docker on worker VMs
iter=1
for i in "${WORKER_IP_LIST[@]}"
do
    # build & save the current worker vm alias
    alias_name="${ENV}-${SSH_ALIAS_PREFIX_WORKER}-${iter}"
    ssh_args="-i $PATH_TO_WORKER_PRIVATE_KEY ${USER_NAME}@${i}"
    alias="alias ${alias_name}='ssh ${ssh_args}'"
    echo $alias >> ~/.bash_aliases

    # send vm init script to current worker VM & execute it
    scp -oStrictHostKeyChecking=no -i $PATH_TO_WORKER_PRIVATE_KEY /tmp/vm-init.sh ${USER_NAME}@${i}:/tmp/vm-init.sh
    ssh -oStrictHostKeyChecking=no $ssh_args "nohup sh -c 'chmod +x /tmp/vm-init.sh && /tmp/vm-init.sh' > /tmp/vm-init.log 2>&1 &"

    ((iter++))
done
