#!/usr/bin/env bash

# Get root up in here
sudo su

apt-get update
apt-get install python-software-properties
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install glusterfs-server glusterfs-client ganglia-monitor nagios-nrpe-server curl -y

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

#setup config here
#sed -i 's/#cluster.name: elasticsearch/cluster.name: fileroom/g' /etc/elasticsearch/elasticsearch.yml 
gluster peer probe gfs1

gluster peer probe gfs2

gluster volume create gluster-volume replica 3 transport tcp gfs1:/gluster-storage gfs2:/gluster-storage gfs3:/gluster-storage

gluster volume start gluster-volume

cp /vagrant/etc.ganglia.gmond.conf /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart