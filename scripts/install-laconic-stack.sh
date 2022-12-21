#!/bin/bash
set -euo pipefail  ## https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# script assumes root perms on a fresh Ubuntu droplet (4vcpu-8gb)
# perms also required for priv GH repos
# TODO simple config for ssh-agent

# dismiss the popups
export DEBIAN_FRONTEND=noninteractive 

apt update -y && apt upgrade -y

# TODO remove when user mode is fixed: https://github.com/cerc-io/stack-orchestrator/issues/69
# or Zach just try again using user mode but run from correct directory
# for stack-orchestator developer mode
apt install python3.10-venv -y

# if you don't install yarn this way you'll get the error describer here:
# https://stackoverflow.com/questions/53471063/yarn-error-there-are-no-scenarios-must-have-at-least-one
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt update -y && apt install yarn -y

apt install docker-compose -y

## need to do this for Linux <-> docker-compose
mkdir -p ~/.docker/cli-plugins

curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

## setup postgres
apt install postgresql postgresql-contrib -y
systemctl start postgresql.service

# change the password to 'postgres' https://stackoverflow.com/a/12721020
# TODO this is scriptable

# $ sudo -u postgres psql # enters you into the console
# $ postgres=# \password postgres
# $ Enter new password: postgres
# $ postgres=# \q

## clone the two repos we'll be using
git clone https://github.com/cerc-io/stack-orchestrator.git
git clone https://github.com/cerc-io/watcher-ts.git

# build `laconic-so` binary
# TODO remove this when #69 is fixed & remove venv install above
# do this manually it didn't script well
# $ python3 -m venv venv
# $ source venv/bin/activate
# $ pip install --editable .
# $ laconic-so
