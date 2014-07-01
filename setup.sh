#this is main set up file
#it will create apliance

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

apt-get update
apt-get install python-software-properties -y
apt-get updatecd /

apt-get install ganglia-monitor nagios-nrpe-server curl -y
apt-get install spawn-fcgi fcgiwrap -y
apt-get install nginx php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php-apc php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl -y
sudo apt-get install git -y

git clone https://github.com/n0needt0/fbg fbg_tmp

# doo other things then switch to fbg user to start things up

cp fbg_tmp/etc/nginx/sites-enabled/proxy /etc/nginx/sites-enabled/proxy
cp fbg_tmp/appliance/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf

mkdir -p /var/www
cp -r fbg_tmp/vbox /var/www

chown -R www-data:www-data /var/www/vbox

#configure fpm
sed -i 's/listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php5-fpm\.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

#updating host file skipping empties and duplicates
 
cat fbg_tmp/appliance/config/hosts | while read line
do
    if [ ! -z "$line" ]; then
    #skip empty
    FILE="/tmp/fbg.1.txt"; 
    FILE2="/tmp/fbg.2.txt"; 
    cat /etc/hosts > $FILE 2> /dev/null; 
    cat $FILE | grep -v "$line" > $FILE2; 
    echo "$line" >> $FILE2; 
    cp $FILE2 /etc/hosts;
    rm  $FILE $FILE2;
    fi
done

/etc/init.d/php5-fpm restart
/etc/init.d/nginx restart
/etc/init.d/ganglia-monitor restart

#echo "Exiting root and dropping to user $username"

#su -c "cd /home/$username/fbg/appliance; bash destroyall.sh" -m "$username"
#su -c "cd /home/$username; git clone https://github.com/n0needt0/fbg" -m "$username" 
#su -c "cd /home/$username/fbg/appliance; bash startall.sh" -m "$username"

rm -rf fbg_tmp