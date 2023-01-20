#!/bin/bash
set -euo pipefail  ## https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# script assumes root perms on a fresh Ubuntu droplet (4vcpu-8gb)

# dismiss the popups
export DEBIAN_FRONTEND=noninteractive 

apt update -y && apt upgrade -y

# this will also install `docker`
apt install docker-compose -y

## need to do this for Linux <-> docker-compose when not installed with Docker Desktop
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# install `laconic-so`
mkdir ~/bin
curl -L -o ~/bin/laconic-so https://github.com/cerc-io/stack-orchestrator/releases/latest/download/laconic-so
chmod +x ~/bin/laconic-so

# add this line to ~/.profile for a more permanent setup
export PATH=$PATH:~/bin

# verify operation
laconic-so version

# if developing / exploring watchers, run this script too:
# ./install-watcher-deps.sh
