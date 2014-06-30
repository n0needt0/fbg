#!/usr/bin/env bash

# Get root up in here
sudo su

apt-get update
apt-get install python-software-properties -y
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4 -y
add-apt-repository ppa:duh/golang -y

apt-get update
apt-get install glusterfs-client ganglia-monitor nagios-nrpe-server curl -y

sudo apt-get install git -y

debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD'
apt-get -y install mysql-server

apt-get -q -y mysql-client

mysql -u root -pMYPASSWORD  < /vagrant/fbg.sql
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*

sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/tmp\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

cp /vagrant/etc/nginx/sites-enabled/api /etc/nginx/sites-enabled/api
cp /vagrant/etc/nginx/conf.d/microcache.conf /etc/nginx/conf.d/microcache.conf
cp /vagrant/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf

cat /var/config/hosts >> /etc/hosts

/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/ganglia-monitor restart

chmod 666 /tmp/php5-fpm.sock

mkdir /gfs

sudo mount -t glusterfs gfs1:/gluster-volume /gfs

chmod 777 /gfs

#add laravel dirs
mkdir -p /opt/fbg_cache 
mkdir -p /opt/fbg_cache/sessions
mkdir -p /opt/fbg_cache/meta
mkdir -p /opt/fbg_cache/views
mkdir -p /opt/fbg_cache/cache

chown -R www-data:root /opt/fbg_cache
chown -R www-data:root /var/log/nginx
