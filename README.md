#This is for dev install

#Step 1. Run as root on both nodes A and B first

apt-get update -y

apt-get install git

apt-get upgrade -y

cd /opt

git clone https://github.com/n0needt0/fbg fbg

cd /opt/fbg

#Virtual Install

This is most common dev setup where you can run just one node, or multiple nodes as separate vms.

cd /opt/fbg/node  

and edit config.json

example is for 2 node install

set the "node":"THE CURRENT NODE being installed, it should be in nodes collection"

run vagrant up

