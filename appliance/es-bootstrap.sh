!/usr/bin/env bash

# Get root up in here
sudo su

sudo apt-get update
sudo apt-get install openjdk-7-jre-headless -y

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
sudo dpkg -i elasticsearch-1.2.1.deb

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.30		api" >> /etc/hosts