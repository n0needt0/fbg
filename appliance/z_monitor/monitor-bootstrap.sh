#!/usr/bin/env bash

# Get root up in here

sudo su

export DEBIAN_FRONTEND=noninteractive ; 

apt-get update
apt-get install python-software-properties -y
apt-get install nagios3 nagios-nrpe-plugin ganglia-monitor rrdtool gmetad curl git -y
apt-get install ganglia-webfrontend spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

#we are not using apache
/etc/init.d/apache2 stop
apt-get remove apache2 -y

#fixup hosts
sed -i 's/localhost/monitor/g' /etc/hosts
cat /var/config/hosts >> /etc/hosts

#clean nginx
rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*

#configure fpm
sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

#configure nNGINX
cp /vagrant/etc/nginx/conf.d/microcache.conf /etc/nginx/conf.d/microcache.conf
cp /vagrant/etc/nginx/sites-enabled/common /etc/nginx/sites-enabled/common
cp /vagrant/etc/nginx/sites-enabled/ganglia /etc/nginx/sites-enabled/ganglia
cp /vagrant/etc/nginx/sites-enabled/nagios /etc/nginx/sites-enabled/nagios

#configure ganglia
cp /vagrant/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cp /vagrant/etc/ganglia/gmetad.conf /etc/ganglia/gmetad.conf

#configure nagios 
cp /vagrant/etc/nagios3/htpasswd.users /etc/nagios3/htpasswd.users
cp -r /etc/nagios3/stylesheets /usr/share/nagios3/htdocs
rm /etc/nagios3/conf.d/*
cp /vagrant/etc/nagios3/conf.d/* /etc/nagios3/conf.d/
cp /var/config/etc/nagios3/conf.d/* /etc/nagios3/conf.d/

sed -i 's/url_html_path=\/nagios3/url_html_path=\//g' /etc/nagios3/cgi.cfg
sed -i 's/use_authentication=1/use_authentication=0/g' /etc/nagios3/cgi.cfg

#restart 
/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/nagios3 restart
/etc/init.d/ganglia-monitor restart
/etc/init.d/gmetad restart