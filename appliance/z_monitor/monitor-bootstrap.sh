#!/usr/bin/env bash

# Get root up in here

sudo su

apt-get update
apt-get install python-software-properties -y
#add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update
apt-get install ganglia-monitor rrdtool gmetad curl git -y 
apt-get install ganglia-webfrontend -y

apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

apt-get remove apache2

rm /etc/nginx/sites-enabled/*

sed -i 's/localhost/monitor/g' /etc/hosts

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

cp /vagrant/etc/nginx/sites-enabled/ganglia /etc/nginx/sites-enabled/ganglia

cp /vagrant/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cp /vagrant/etc/ganglia/gmetad.conf /etc/ganglia/gmetad.conf
cp /vagrant/etc/nginx/sites-enabled/nagios /etc/nginx/sites-enabled/nagios

cp /vagrant/etc/nagios3/htpasswd.users /etc/nagios3/htpasswd.users
cp /vagrant/etc/nagios3/conf.d/contacts_nagios2.cfg /etc/nagios3/conf.d/contacts_nagios2.cfg
cp /vagrant/etc/nagios3/conf.d/fbg-servers.cfg /etc/nagios3/conf.d/fbg-servers.cfg

sed -i 's/url_html_path=\/nagios3/url_html_path=\//g' /etc/nagios3/cgi.cfg

/etc/init.d/nginx restart
/etc/init.d/ganglia-monitor restart
/etc/init.d/gmetad restart