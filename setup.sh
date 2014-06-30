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
sudo apt-get install git -y
apt-get install nginx -y

rm -rf fbg_tmp

git clone https://github.com/n0needt0/fbg fbg_tmp

# doo other things then switch to fbg user to start things up

cp fbg_tmp/etc/nginx/sites-enabled/proxy /etc/nginx/sites-enabled/proxy
cp fbg_tmp/appliance/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cat fbg_tmp/appliance/config/hosts >> /etc/hosts
/etc/init.d/ganglia-monitor restart
/etc/init.d/nginx restart

echo "Exiting root and dropping to user $username"
su $username

cd ~
git clone https://github.com/n0needt0/fbg 

cd fbg/appliance

#this needs to happen because use
#configure nginx, gaglia and nagios
