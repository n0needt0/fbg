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

switch to specified user (in this case fbguser) and his home directory

like so

su fbguser

cd /home/fbguser

vagrant plugin install vagrant-vbguest

cd fbg/appliance 

bash startall.sh
