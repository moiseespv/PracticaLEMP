#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install -y nginx php7.4 php7.4-fpm php7.4-mysql php7.4-xml php7.4-zip php7.4-curl php7.4-mbstring nfs-common wget

sudo mkdir -p /var/www/owncloud
sudo mount 192.168.60.30:/var/www/owncloud /var/www/owncloud

# Configurar nginx para OwnCloud
cat > /etc/nginx/sites-available/owncloud <<EOL
server {
    listen 80;
    server_name localhost;

    root /var/www/owncloud;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL

# Activar configuración y reiniciar nginx
ln -s /etc/nginx/sites-available/owncloud /etc/nginx/sites-enabled/
sudo systemctl restart nginx
