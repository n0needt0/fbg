#!/usr/bin/env bash

# Get root up in here
sudo su

sudo apt-get update
sudo apt-get install openjdk-7-jre-headless ganglia-monitor nagios-nrpe-server curl -y

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
sudo dpkg -i elasticsearch-1.2.1.deb

cat /var/config/hosts >> /etc/hosts

apt-get install glusterfs-client -y

#setup config here
sed -i 's/#cluster.name: elasticsearch/cluster.name: fileroom/g' /etc/elasticsearch/elasticsearch.yml 
sed -i 's/#node.name: "Franz Kafka"/node.name: "es1"/g' /etc/elasticsearch/elasticsearch.yml 
sed -i 's/#network.host: 192.168.0.1/network.host: 10.10.10.11/g' /etc/elasticsearch/elasticsearch.yml 
sed -i 's/#transport.tcp.compress: true/transport.tcp.compress: true/g' /etc/elasticsearch/elasticsearch.yml 
sed -i 's/#index.number_of_replicas: 1/index.number_of_replicas: 3/g' /etc/elasticsearch/elasticsearch.yml 
sed -i 's/#discovery.zen.minimum_master_nodes: 1/discovery.zen.minimum_master_nodes: 2/g' /etc/elasticsearch/elasticsearch.yml

#sed -i 's//g' /etc/elasticsearch/elasticsearch.yml 

/etc/init.d/elasticsearch restart

cd /usr/share/elasticsearch

bin/plugin -i elasticsearch/marvel/latest

echo "marvel.agent.exporter.es.hosts: [\"10.10.10.11:9200\",\"10.10.10.12:9200\",\"10.10.10.13:9200\"]" >> /etc/elasticsearch/elasticsearch.yml

/etc/init.d/elasticsearch restart

cp /var/config/etc/ganglia/gmond.conf /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart
