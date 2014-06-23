#!/usr/bin/env bash

# Get root up in here
apt-get update
apt-get install python-software-properties
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install glusterfs-client ganglia-monitor nagios-nrpe-server curl -y

sudo apt-get install git -y
sudo apt-get install mercurial -y
sudo apt-get install make -y
sudo apt-get install binutils -y
sudo apt-get install bison -y
sudo apt-get install gcc -y

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server
apt-get install php5-mysql nginx php5-fpm -y

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

mkdir /gfs

sudo mount -t glusterfs gfs1:/gluster-volume /gfs

chmod 777 /gfs

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

gvm install go1
gvm use go1 