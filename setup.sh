#this is main set up file
#it will create apliance
sudo su

echo "10.10.10.1"       mother >> /etc/hosts
echo "10.10.10.11       es1" >> /etc/hosts
echo "10.10.10.12       es2" >> /etc/hosts
echo "10.10.10.13       es3" >> /etc/hosts
echo "10.10.10.21       gfs1" >> /etc/hosts
echo "10.10.10.22       gfs2" >> /etc/hosts
echo "10.10.10.23       gfs3" >> /etc/hosts
echo "10.10.10.31       api" >> /etc/hosts
echo "10.10.10.41       monitor" >> /etc/hosts

apt-get update
apt-get install python-software-properties -y
apt-get update
apt-get install ganglia-monitor nagios-nrpe-server curl -y

sudo apt-get install git -y

apt-get install nginx -y 
#php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

#configure nginx, gaglia and nagios
