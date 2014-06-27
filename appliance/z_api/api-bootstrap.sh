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
apt-get -q -y install mysql-server mysql-client
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*

sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/tmp\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
#sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
#sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
#sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

cat /vagrant/etc.nginx.sites-enabled.api > /etc/nginx/sites-enabled/api
cat /vagrant/etc.nginx.conf.d.microcache.conf > /etc/nginx/conf.d/microcache.conf

echo "10.10.10.11		es1" >> /etc/hosts
echo "10.10.10.12		es2" >> /etc/hosts
echo "10.10.10.13		es3" >> /etc/hosts
echo "10.10.10.21		gfs1" >> /etc/hosts
echo "10.10.10.22		gfs2" >> /etc/hosts
echo "10.10.10.23		gfs3" >> /etc/hosts
echo "10.10.10.31		api" >> /etc/hosts
echo "10.10.10.41		monitor" >> /etc/hosts

/etc/init.d/php5-fpm reload
/etc/init.d/nginx reload

mkdir /gfs

sudo mount -t glusterfs gfs1:/gluster-volume /gfs

chmod 777 /gfs

