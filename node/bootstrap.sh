#bring root
sudo su

apt-get install curl git -y
apt-get install python-software-properties -y
apt-get update
apt-get install spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y
sudo apt-get install openjdk-7-jre-headless -y

#install elastic
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
sudo dpkg -i elasticsearch-1.2.1.deb
rm elasticsearch-1.2.1.deb

debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD'

apt-get -y install mysql-server
apt-get -q -y mysql-client

mysql -u root -pMYPASSWORD  < /vagrant/config/fbg.sql

#we are not using apache
/etc/init.d/apache2 stop
apt-get remove apache2 -y

rm /etc/nginx/sites-enabled/*
rm /etc/nginx/sites-available/*

sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

cp /vagrant/config/etc/nginx/sites-enabled/api /etc/nginx/sites-enabled/api
cp /vagrant/config/etc/nginx/conf.d/microcache.conf /etc/nginx/conf.d/microcache.conf

#add laravel dirs
mkdir -p /opt/fbg_cache 
mkdir -p /opt/fbg_cache/sessions
mkdir -p /opt/fbg_cache/meta
mkdir -p /opt/fbg_cache/views
mkdir -p /opt/fbg_cache/cache

chown -R www-data:root /opt/fbg_cache
chown -R www-data:root /var/log/nginx

#Configure elastic

sed -i "s/#cluster.name: elasticsearch/cluster.name: fileroom/g" /etc/elasticsearch/elasticsearch.yml 

/etc/init.d/elasticsearch restart

/usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest
/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head

echo "marvel.agent.exporter.es.hosts: [\"localhost:9200\"]" >> /etc/elasticsearch/elasticsearch.yml

/etc/init.d/elasticsearch restart
/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart

mkdir /gfs
chmod 777 /gfs  

echo "follow the yellow brick road..."
