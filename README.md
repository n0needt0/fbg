#This is new cluster install for UBUNTU 12.04LTS

#Run as root on both nodes A and B

apt-get update -y

apt-get install git

apt-get upgrade -y

git clone https://github.com/n0needt0/fbg fbginstall 

edit config.cfg file per your network requirements, basically you want free private network block

#then

cd fbginstall && bash setup.sh

#and then 

cd ..

rm -rf fbginstall

switch to specified user (in this case fbguser) and his home directory

like so

su fbguser

cd /home/fbguser

#update vagrant plugins

vagrant plugin install vagrant-vbguest

#clone the repo

cd fbg/appliance 

bash startall.sh
