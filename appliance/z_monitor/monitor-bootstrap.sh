#!/usr/bin/env bash

# Get root up in here

sudo su

apt-get update
apt-get install python-software-properties -y
#add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install ganglia-monitor rrdtool gmetad curl git -y 
apt-get install ganglia-webfrontend -qq -y

sed -i 's/localhost/monitor/g' /etc/hosts

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

cp /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/ganglia.conf
cp /vagrant/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cp /vagrant/etc/ganglia/gmetad.conf /etc/ganglia/gmetad.conf
cp /vagrant/etc/apache2/sites-enabled/nagios.conf /etc/apache2/sites-enabled/nagios.conf

cp /vagrant/etc/nagios3/htpasswd.users /etc/nagios3/htpasswd.users
cp /vagrant/etc/nagios3/conf.d/contacts_nagios2.cfg /etc/nagios3/conf.d/contacts_nagios2.cfg
cp /vagrant/etc/nagios3/conf.d/fbg-servers.cfg /etc/nagios3/conf.d/fbg-servers.cfg

/etc/init.d/apache2 restart
/etc/init.d/ganglia-monitor restart
/etc/init.d/gmetad restart

#configure ganglia and nagios
