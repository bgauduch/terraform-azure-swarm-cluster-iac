#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# update package list & upgrade packages
sudo apt-get update -qq #&& sudo apt-get upgrade -y -qq

# install docker
sudo apt-get install -y -qq --no-install-recommends curl
curl -fsSL get.docker.com | sh

# add user to docker group
sudo usermod -aG docker $USER