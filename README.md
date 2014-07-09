#This is new cluster install for UBUNTU 12.04LTS

#Before you begin 

Add private address to eth0 from same network you will use in config in Step 1. 

to each of host nodes and restart networking


#Step 1. Run as root on both nodes A and B first

apt-get update -y

apt-get install git

apt-get upgrade -y

cd /opt

git clone https://github.com/n0needt0/fbg fbg

edit config.cfg file per your network requirements, basically you want free private network block

#then

cd /opt/fbginstall

bash setup_node.sh

#test Step 1.

check that...

#Step 2. Run on each node after completing step 1 on both nodes

cd /opt/fbginstall

bash start_gfs.sh

#test Step 2.

check that...

#Step 3

switch to specified user (in this case fbguser) and his home directory

like so

su fbguser

cd /home/fbguser/fbg/appliance 

vagrant plugin install vagrant-vbguest

bash startall.sh
