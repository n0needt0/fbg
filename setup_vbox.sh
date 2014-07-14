#this is main set up file
#it will create apliance

/usr/sbin/ntpdate pool.ntp.org

if [ $(id -u) -eq 0 ]; then
    read -p "Enter username to use for VBox webservice access:" username
    read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$username exists!"
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass $username
        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    fi
else
    echo "Only root may add a user to the system"
    exit 2
fi

adduser $username vboxusers

apt-get install python-software-properties -y

grep -q 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' /etc/apt/sources.list || echo 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' >>  /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update

#install virtual box here
apt-get install linux-headers-$(uname -r) build-essential virtualbox-4.2 dkms -y
wget http://download.virtualbox.org/virtualbox/4.2.24/Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack
rm Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack

apt-get install spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y

#configure vbox service
mkdir -p /var/www
cp -r vbox /var/www

sed -i "s/\$username = \x27vbox\x27/\$username = \'$username\'/g" /var/www/vbox/config.php
sed -i "s/\$password = \x27pass\x27/\$password = \'$password\'/g" /var/www/vbox/config.php

rm /etc/default/virtualbox
echo "LOAD_VBOXDRV_MODULE=1" >> /etc/default/virtualbox
echo "VBOXWEB_USER=$username" >> /etc/default/virtualbox
echo "SHUTDOWN_USERS=\"\"" >> /etc/default/virtualbox
echo "SHUTDOWN=poweroff" >> /etc/default/virtualbox

chown -R www-data:www-data /var/www/vbox

#configure fpm
sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/vboxweb-service start
/etc/init.d/vboxweb-service start

echo "follow the yellow brick road..."