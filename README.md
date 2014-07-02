#This is new install ONLY for re-install see below

#Run as root

apt-get update -y

apt-get upgrade -y

bash <(curl -s https://raw.githubusercontent.com/n0needt0/fbg/master/setup.sh)

#thereafter 

switch to specified user (in this case fbguser) and his home directory

like so

su fbguser

cd /home/fbguser

#update vagrant plugins

vagrant plugin install vagrant-vbguest

#clone the repo

git clone https://github.com/n0needt0/fbg && cd fbg/appliance && bash startall.sh

#REINSTALL Instructions

su fbguser

#clean this mess up

cd /home/fbguser/fbg/appliance && bash destroyall.sh

rm -rf /home/fbguser/fbg

rm -rf /home/fbuser/.vagrant*

#clone the repo

git clone https://github.com/n0needt0/fbg && cd fbg/appliance && bash startall.sh

