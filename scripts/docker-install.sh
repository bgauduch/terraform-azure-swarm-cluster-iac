#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# update package list
sudo apt-get update

# install docker
sudo apt-get install -y -qq --no-install-recommends curl
curl -fsSL get.docker.com | sh

# add user to docker group
sudo usermod -aG docker $USER