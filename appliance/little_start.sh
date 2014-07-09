## start only the VMs that we want
## start z_api
cd z_api
echo "Installing z_api virtual machine..."
sleep 2
vagrant up
cd ..
## start z_monitor
cd z_monitor
echo "Installing z_monitor virtual machine..."
sleep 2
vagrant up
cd ..
## start es1
cd es1
echo "Installing es1 virtual machine..."
sleep 2
vagrant up
cd ..
## start gfs1
cd gfs1
echo "Installing gfs1 virtual machine..."
sleep 2
vagrant up
cd ..
## finish
