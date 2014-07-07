#!/usr/bin/env bash

# Get root up in here
sudo su

#run install script
source /var/config/bash/gfs.sh

#setup config here

gluster peer probe gfs1a
gluster peer probe gfs2a
gluster peer probe gfs3a
gluster peer probe gfs1b
gluster peer probe gfs2b
gluster peer probe gfs3b

gluster volume create gluster-volume replica 3 transport tcp gfs1a:/gluster-storage gfs2a:/gluster-storage gfs3a:/gluster-storage gfs1b:/gluster-storage gfs2b:/gluster-storage gfs3b:/gluster-storage

gluster volume start gluster-volume