sudo su
gluster peer probe nodea
gluster peer probe nodeb
gluster volume create gluster-volume replica 2 transport tcp nodea:/gluster-storage nodeb:/gluster-storage
gluster volume start gluster-volume

mkdir /gfs
mount -t glusterfs localhost:/gluster-volume /gfs
chmod 777 /gfs  