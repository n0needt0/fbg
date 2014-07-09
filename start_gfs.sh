sudo su
gluster peer probe nodea
gluster peer probe nodeb
gluster volume create gluster-volume replica 3 transport tcp nodea:/gluster-storage nodeb:/gluster-storage
gluster volume start gluster-volume
