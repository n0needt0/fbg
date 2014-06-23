#!/usr/bin/env bash

# Get root up in here
apt-get update
apt-get install python-software-properties -y
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install glusterfs-client ganglia-monitor ganglia-webfrontend-y

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

mkdir /storage-pool

sudo mount -t glusterfs gfs1:/gluster-volume /storage-pool

chmod 777 /storage-pool