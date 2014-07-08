#this is main set up file
#it will create apliance

source ./config.cfg

#generate hosts file
echo "" > config/common/hosts

echo "$NODE_A        nodea" >> config/common/hosts
echo "$NODE_B        nodeb" >> config/common/hosts

echo "$ES1_A        es1a" >> config/common/hosts
echo "$ES1_B        es1b" >> config/common/hosts

echo "$ES2_A        es2a" >> config/common/hosts
echo "$ES2_B        es2b" >> config/common/hosts

echo "$ES3_A        es3a" >> config/common/hosts
echo "$ES3_B        es3b" >> config/common/hosts

echo "$GFS1_A        gfs1a" >> config/common/hosts
echo "$GFS1_B        gfs1b" >> config/common/hosts

echo "$GFS2_A        gfs2a" >> config/common/hosts
echo "$GFS2_B        gfs2b" >> config/common/hosts

echo "$GFS3_A        gfs3a" >> config/common/hosts
echo "$GFS3_B        gfs3b" >> config/common/hosts

echo "$API_A        apia" >> config/common/hosts
echo "$API_B        apib" >> config/common/hosts

echo "$MONITOR_A        monitora" >> config/common/hosts
echo "$MONITOR_B        monitorb" >> config/common/hosts

#generate vagrant configs
echo "#Vagrant setup" > config/common/vagrant.yml
echo "#Vagrant setup" > config/common/vagrant.sh

read -p "Running system upgrade!!! Continue? (y/n) " RESP
if [ "$RESP" != "y" ]; then
  exit 1;
fi

read -p "What node are you installing (A/B)? " CLUSTERSIDE
 
#generate HOST CONFIG files

if [ "$CLUSTERSIDE" == "A" ]; then
  echo "Generating Cluster node A..."
  
  echo " eth: $ETH_A" >> config/common/vagrant.yml
  echo " memory: $APPLIANCE_MEMORY_A" >> config/common/vagrant.yml
  echo " es1_name: es1a" >> config/common/vagrant.yml
  echo " es1_ip: $ES1_A" >> config/common/vagrant.yml
  echo " es2_name: es2a" >> config/common/vagrant.yml
  echo " es2_ip: $ES2_A" >> config/common/vagrant.yml
  echo " es3_name: es3a" >> config/common/vagrant.yml
  echo " es3_ip: $ES3_A" >> config/common/vagrant.yml
  echo " gfs1_name: gfs1a" >> config/common/vagrant.yml
  echo " gfs1_ip: $GFS1_A" >> config/common/vagrant.yml
  echo " gfs2_name: gfs2a" >> config/common/vagrant.yml
  echo " gfs2_ip: $GFS2_A" >> config/common/vagrant.yml
  echo " gfs3_name: gfs3a" >> config/common/vagrant.yml
  echo " gfs3_ip: $GFS3_A" >> config/common/vagrant.yml
  echo " api_name: apia" >> config/common/vagrant.yml
  echo " api_ip: $API_A" >> config/common/vagrant.yml
  echo " monitor_name: monitora" >> config/common/vagrant.yml
  echo " monitor_ip: $MONITOR_A" >> config/common/vagrant.yml
  
  echo "$ES1_A        es1" >> config/common/hosts
  echo "$ES2_A        es2" >> config/common/hosts
  echo "$ES3_A        es3" >> config/common/hosts
  echo "$GFS1_A        gfs1" >> config/common/hosts
  echo "$GFS2_A        gfs2" >> config/common/hosts
  echo "$GFS3_A        gfs3" >> config/common/hosts
  echo "$API_A        api" >> config/common/hosts
  echo "$MONITOR_A        monitor" >> config/common/hosts
  
elif [ "$CLUSTERSIDE" == "B" ]; then
  echo "Generating Cluster node B..."
  
  echo " eth: $ETH_B" >> config/common/vagrant.yml
  echo " memory: $APPLIANCE_MEMORY_B" >> config/common/vagrant.yml
  echo " es1_name: es1b" >> config/common/vagrant.yml
  echo " es1_ip: $ES1_B" >> config/common/vagrant.yml
  echo " es2_name: es2b" >> config/common/vagrant.yml
  echo " es2_ip: $ES2_B" >> config/common/vagrant.yml
  echo " es3_name: es3b" >> config/common/vagrant.yml
  echo " es3_ip: $ES3_B" >> config/common/vagrant.yml
  echo " gfs1_name: gfs1b" >> config/common/vagrant.yml
  echo " gfs1_ip: $GFS1_B" >> config/common/vagrant.yml
  echo " gfs2_name: gfs2b" >> config/common/vagrant.yml
  echo " gfs2_ip: $GFS2_B" >> config/common/vagrant.yml
  echo " gfs3_name: gfs3b" >> config/common/vagrant.yml
  echo " gfs3_ip: $GFS3_B" >> config/common/vagrant.yml
  echo " api_name: apib" >> config/common/vagrant.yml
  echo " api_ip: $API_B" >> config/common/vagrant.yml
  echo " monitor_name: monitorb" >> config/common/vagrant.yml
  echo " monitor_ip: $MONITOR_B" >> config/common/vagrant.yml
  
  echo "$ES1_B        es1" >> config/common/hosts
  echo "$ES2_B        es2" >> config/common/hosts
  echo "$ES3_B        es3" >> config/common/hosts
  echo "$GFS1_B        gfs1" >> config/common/hosts
  echo "$GFS2_B        gfs2" >> config/common/hosts
  echo "$GFS3_B        gfs3" >> config/common/hosts
  echo "$API_B        api" >> config/common/hosts
  echo "$MONITOR_B        monitor" >> config/common/hosts
  
else
    echo "Unknown node. Exiting....";
    exit 0;  
fi

sed -e 's/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' config/common/vagrant.yml > config/common/vagrant.sh

echo "Continued with generated cluster addresses, please check..."
cat config/common/vagrant.yml
cat config/common/hosts

read -p "Continue? (y/n) " RESP
if [ "$RESP" != "y" ]; then
  exit 1;
fi

if [ $(id -u) -eq 0 ]; then
    
    read -p "Enter username to install under: " username
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

grep -q 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' /etc/apt/sources.list || echo 'deb http://download.virtualbox.org/virtualbox/debian precise contrib' >>  /etc/apt/sources.list

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update

#install virtual box here
apt-get install linux-headers-$(uname -r) build-essential virtualbox-4.2 dkms -y

wget http://download.virtualbox.org/virtualbox/4.2.24/Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack
rm Oracle_VM_VirtualBox_Extension_Pack-4.2.24-92790.vbox-extpack

apt-get install python-software-properties -y
apt-get install ganglia-monitor nagios-nrpe-server curl -y
apt-get install spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y
sudo apt-get install git -y

cp config/etc/nginx/sites-enabled/proxy /etc/nginx/sites-enabled/proxy
cp config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf

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

#updating host file skipping empties and duplicates
 echo "#FBGHOSTS" > /etc/hosts
 
cat config/common/hosts | while read line
do
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

echo "#FBGHOSTS" > /etc/hosts

/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/ganglia-monitor restart
/etc/init.d/vboxweb-service restart

wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb

dpkg -i vagrant_1.6.3_x86_64.deb

rm vagrant_1.6.3_x86_64.deb

vagrant plugin install vagrant-vbguest

#change properties to appliance

rm -rf /home/$username/fbg

mkdir -p /home/$username/fbg

cp -r appliance /home/$username/fbg
cp -r config /home/$username/fbg
cp -r backend /home/$username/fbg

chown -R $username:$username /home/$username

/etc/init.d/vboxweb-service restart