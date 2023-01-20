#!/bin/bash
set -euo pipefail  ## https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# helper script for installing watcher repo dependencies


# if you don't install yarn this way you'll get the error describer here:
# https://stackoverflow.com/questions/53471063/yarn-error-there-are-no-scenarios-must-have-at-least-one
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt update -y && apt install yarn -y


## setup postgres
apt install postgresql postgresql-contrib -y
systemctl start postgresql.service

# change the password to 'postgres' https://stackoverflow.com/a/12721020
# TODO this is scriptable

# $ sudo -u postgres psql # enters you into the console
# $ postgres=# \password postgres
# $ Enter new password: postgres
# $ postgres=# \q

git clone https://github.com/cerc-io/watcher-ts.git
