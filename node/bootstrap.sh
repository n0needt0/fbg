#bring root
sudo su

echo "ENV Variables"
echo "FBGNODE=$FBGNODE"
echo "FBGNODES=$FBGNODES"
echo "FBGIPS=$FBGIPS"
echo "ESNODES=$ESNODES"

echo "Added to /etc/hosts file"
cat /etc/fbghosts | while read line
do
    echo $line
    if [ ! -z "$line" ]; then
    #skip empty
    FILE="/tmp/fbg.1.txt"; 
    FILE2="/tmp/fbg.2.txt"; 
    cat /etc/hosts > $FILE 2> /dev/null; 
    cat $FILE | grep -vFx "$line" > $FILE2; 
    echo "$line" >> $FILE2; 
    cp $FILE2 /etc/hosts;
    rm  $FILE $FILE2;
    fi
done

apt-get install curl git -y
apt-get install python-software-properties -y
add-apt-repository ppa:semiosis/ubuntu-glusterfs-3.4
apt-get update

#install glusterfs
apt-get install glusterfs-server glusterfs-client -y

apt-get install nagios-nrpe-server -y
apt-get install nagios3 nagios-nrpe-plugin ganglia-monitor rrdtool gmetad curl git -y
apt-get install ganglia-webfrontend -y
apt-get install spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y
sudo apt-get install openjdk-7-jre-headless ganglia-monitor nagios-nrpe-server curl -y

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
sed -i "s/#node.name: \"Franz Kafka\"/node.name: $FBGCNODE/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#network.host: 192.168.0.1/network.host: $FBGCIP/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#index.number_of_replicas: 1/index.number_of_replicas: 2/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#discovery.zen.minimum_master_nodes: 1/discovery.zen.minimum_master_nodes: 1/g" /etc/elasticsearch/elasticsearch.yml
sed -i "s/#gateway.expected_nodes: 2/gateway.expected_nodes: 2/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/discovery.zen.ping.timeout: 3s/discovery.zen.ping.timeout: 10s/g" /etc/elasticsearch/elasticsearch.yml 

/etc/init.d/elasticsearch restart

/usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest
/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head

echo "marvel.agent.exporter.es.hosts: [$ESNODES]" >> /etc/elasticsearch/elasticsearch.yml

#setup ganglia and nagios here
cp /vagrant/config/etc/nginx/sites-enabled/common /etc/nginx/sites-enabled/common
cp /vagrant/config/etc/nginx/sites-enabled/ganglia /etc/nginx/sites-enabled/ganglia
cp /vagrant/config/etc/nginx/sites-enabled/nagios /etc/nginx/sites-enabled/nagios

#configure ganglia
cp /vagrant/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cp /vagrant/config/etc/ganglia/gmetad.conf /etc/ganglia/gmetad.conf

#configure nagios 
cp /vagrant/config/etc/nagios3/htpasswd.users /etc/nagios3/htpasswd.users
cp -r /etc/nagios3/stylesheets /usr/share/nagios3/htdocs
rm /etc/nagios3/conf.d/*
cp /vagrant/config/etc/nagios3/conf.d/* /etc/nagios3/conf.d/

sed -i 's/url_html_path=\/nagios3/url_html_path=\//g' /etc/nagios3/cgi.cfg
sed -i 's/use_authentication=1/use_authentication=0/g' /etc/nagios3/cgi.cfg

/etc/init.d/elasticsearch restart
/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/nagios3 restart
/etc/init.d/gmetad restart
/etc/init.d/ganglia-monitor restart

gluster peer probe nodea
gluster peer probe nodeb
gluster volume create gluster-volume replica 2 transport tcp nodea:/gluster-storage nodeb:/gluster-storage force
gluster volume start gluster-volume
mkdir /gfs
mount -t glusterfs nodea:/gluster-volume /gfs
chmod 777 /gfs  

echo "follow the yellow brick road..."
