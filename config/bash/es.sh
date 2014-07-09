#change hostname

sudo apt-get update
sudo apt-get install openjdk-7-jre-headless ganglia-monitor nagios-nrpe-server curl -y

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
sudo dpkg -i elasticsearch-1.2.1.deb

cat /var/config/common/hosts >> /etc/hosts

apt-get install glusterfs-client -y

#setup config here
sed -i "s/#cluster.name: elasticsearch/cluster.name: fileroom/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#node.name: \"Franz Kafka\"/node.name: $ESNAME/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#network.host: 192.168.0.1/network.host: $ESIP/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#index.number_of_replicas: 1/index.number_of_replicas: 2/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/#discovery.zen.minimum_master_nodes: 1/discovery.zen.minimum_master_nodes: 1/g" /etc/elasticsearch/elasticsearch.yml
sed -i "s/#gateway.expected_nodes: 2/gateway.expected_nodes: 2/g" /etc/elasticsearch/elasticsearch.yml 
sed -i "s/discovery.zen.ping.timeout: 3s/discovery.zen.ping.timeout: 10s/g" /etc/elasticsearch/elasticsearch.yml 

/etc/init.d/elasticsearch restart

/usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest
/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head

echo "marvel.agent.exporter.es.hosts: [\"es1a:9200\",\"es1b:9200\"]" >> /etc/elasticsearch/elasticsearch.yml

/etc/init.d/elasticsearch restart
cp /var/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart
