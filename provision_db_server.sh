#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get install -y mariadb-server

# Configurar base de datos para OwnCloud
mysql -u root <<EOF
CREATE DATABASE owncloud;
CREATE USER 'ownclouduser'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON owncloud.* TO 'ownclouduser'@'%';
FLUSH PRIVILEGES;
EOF

# Configurar MariaDB para escuchar en todas las interfaces
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Reiniciar MariaDB
sudo systemctl restart mariadb
