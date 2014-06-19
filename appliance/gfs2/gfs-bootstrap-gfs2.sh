#!/usr/bin/env bash

# Get root up in here
sudo su

apt-get update
apt-get install python-software-properties
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install glusterfs-server -y

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.30		api" >> /etc/hosts

#setup config here
#sed -i 's/#cluster.name: elasticsearch/cluster.name: fileroom/g' /etc/elasticsearch/elasticsearch.yml 
