#!/usr/bin/env bash

# Get root up in here
sudo su

apt-get update
apt-get install python-software-properties
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install glusterfs-server glusterfs-client ganglia-monitor nagios-nrpe-server curl -y

cat /var/config/hosts >> /etc/hosts

cp /var/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart
