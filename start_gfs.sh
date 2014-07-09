read -p "What node are you installing (A/B)? " CLUSTERSIDE

#generate HOST CONFIG files
if [ "$CLUSTERSIDE" == "A" ]; then

  gluster peer probe nodeb
  gluster volume create gluster-volume replica 2 transport tcp nodea:/gluster-storage nodeb:/gluster-storage force
  gluster volume start gluster-volume
  mkdir /gfs
  mount -t glusterfs nodea:/gluster-volume /gfs
  chmod 777 /gfs  

elif [ "$CLUSTERSIDE" == "B" ]; then

  gluster peer probe nodea
  gluster volume create gluster-volume replica 2 transport tcp nodea:/gluster-storage nodeb:/gluster-storage force
  gluster volume start gluster-volume
  mkdir /gfs
  mount -t glusterfs nodeb:/gluster-volume /gfs
  chmod 777 /gfs

else
    echo "Unknown node. Exiting....";
    exit 0;  
fi

