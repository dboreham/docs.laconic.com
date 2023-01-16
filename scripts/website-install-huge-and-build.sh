#!/bin/bash
apt-get update && apt-get install -y wget 

wget https://github.com/gohugoio/hugo/releases/download/v0.92.0/hugo_extended_0.92.0_Linux-64bit.tar.gz
tar -xzf  hugo_extended_0.92.0_Linux-64bit.tar.gz -C /usr/local/bin
source ~/.bashrc

hugo version
hugo --minify
