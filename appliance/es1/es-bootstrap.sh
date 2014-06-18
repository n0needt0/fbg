#!/usr/bin/env bash

# Get root up in here
sudo su

sudo apt-get update
sudo apt-get install openjdk-7-jre-headless -y

 
# NEW WAY / EASY WAY
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
sudo dpkg -i elasticsearch-1.1.1.deb

#setup config here
 
service elasticsearch start
