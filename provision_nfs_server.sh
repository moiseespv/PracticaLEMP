#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get install -y nfs-kernel-server
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install -y php7.4 php7.4-fpm php7.4-mysql php7.4-xml php7.4-zip php7.4-curl php7.4-mbstring nfs-common wget

sudo mkdir -p /var/www
 # Añadimos las ips de los servidores web y reiniciamos el servicio NFS
 
 sudo sed -i '$a /var/www/owncloud    192.168.60.10(rw,sync,no_subtree_check)' /etc/exports
 sudo sed -i '$a /var/www/owncloud   192.168.60.20(rw,sync,no_subtree_check)' /etc/exports
 sudo systemctl restart nfs-kernel-server
 
 # Instalamos wget y metemos el zip de wordpress en el directorio que hemos creado y lo descomprimimos dentro dandole los respectivos permisos
 
 sudo apt install wget -y
 wget https://download.owncloud.com/server/stable//owncloud-latest.zip
 sudo apt install unzip -y
 sudo mv owncloud-latest.zip /var/www
 cd /var/www/
 sudo unzip owncloud-latest.zip
 sudo chown -R www-data:www-data /var/www/owncloud
 sudo chmod -R 777 /var/www/owncloud



