#!/usr/bin/env bash

# Get root up in here
apt-get update
apt-get install python-software-properties -y
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4 -y
add-apt-repository ppa:duh/golang -y

apt-get update
apt-get install glusterfs-client ganglia-monitor nagios-nrpe-server curl -y

sudo apt-get install git -y

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server
apt-get install php5-mysql apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli php5-mcrypt php5-fpm -y

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

