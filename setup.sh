#this is main set up file
#it will create apliance
sudo su

if [ $(id -u) -eq 0 ]; then
    
    read -p "Enter username to install under: " username
    read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$username exists!"
        exit 1
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
apt-get update
apt-get install ganglia-monitor nagios-nrpe-server curl -y
sudo apt-get install git -y
apt-get install nginx -y

# doo other things then switch to fbg user to start things up

cp appliance/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
cat appliance/config/hosts >> /etc/hosts
/etc/init.d/ganglia-monitor restart

echo "Installing under $username!"

su $username
cd ~
git clone  https://github.com/n0needt0/fbg fbg

cd fbg/appliance

#bash startall.sh

#configure nginx, gaglia and nagios
