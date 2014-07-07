#!/usr/bin/env bash

# Get root up in here
sudo su

#grab some vars
source /var/config/common/vagrant.sh
ESNAME=es2_name
ESIP=es2_ip

#run install script
source /var/config/bash/es.sh