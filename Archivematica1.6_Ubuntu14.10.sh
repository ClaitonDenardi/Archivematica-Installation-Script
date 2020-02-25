#!/bin/bash
# Script de Instalação Archivematica
# Claiton Denardi Paulus & Luis Henrique Medeiros
# BaseGED_2018/1

#Atualizar o repositorio
sudo apt-get update
#Python
sudo apt-get install python-software-properties
#Adicionar o archivematica
sudo add-apt-repository ppa:archivematica/1.4
sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get upgrade
#Instalação do Archivematica
sudo apt-get install archivematica-storage-service
sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage
sudo ln -s /etc/uwsgi/apps-available/storage.ini /etc/uwsgi/apps-enabled/storage.ini
sudo service uwsgi restart
#Reinicia-se o nginx para setar as novas configs
sudo service nginx restart
sudo apt-get install archivematica-mcp-server
sudo apt-get install archivematica-mcp-client
sudo apt-get install archivematica-dashboard
#Instalando o servidor de buscas ElasticSearch
sudo apt-get install elasticsearch
sudo rm -f /etc/apache2/sites-enabled/*default*
sudo wget -q https://raw.githubusercontent.com/artefactual/archivematica/stable/1.4.x/localDevSetup/apache/apache.default -O /etc/apache2/sites-available/default.conf
sudo ln -s /etc/apache2/sites-available/default.conf /etc/apache2/sites-enabled/default.conf
sudo /etc/init.d/apache2 restart
sudo freshclam
sudo /etc/init.d/clamav-daemon start
sudo /etc/init.d/elasticsearch restart
sudo /etc/init.d/gearman-job-server restart
#Iniciando Server
sudo start archivematica-mcp-server
#Iniciando Cliente
sudo start archivematica-mcp-client
sudo start fits
sudo restart gearman-job-server
echo "PRONTO, siga para o Browser..."
