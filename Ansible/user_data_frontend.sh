#!/bin/bash

cd /home/ubuntu

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install nginx git
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install 16

cd ~
GIT_TERMINAL_PROMPT=0 
git clone --recurse-submodule -j8 https://github.com/SalvaChiLlo/Proyecto-IEI
cd Proyecto-IEI
git submodule foreach git checkout main
npm install
cd IEIFront
npm run build

sudo rm /var/www/html/index.nginx-debian.html
sudo cp -r dist/IEIFront/* /var/www/html/
cd ~
sudo rm -rf cd ~/Proyecto-IEI

sudo echo "user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

http {
server {
  listen 80;
  sendfile on;
  default_type application/octet-stream;

  gzip on;
  gzip_http_version 1.1;
  gzip_disable      "MSIE [1-6]\\.";
  gzip_min_length   256;
  gzip_vary         on;
  gzip_proxied      expired no-cache no-store private auth;
  gzip_types        text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;
  gzip_comp_level   9;

  root /var/www/html/;

  location / {
    try_files \$uri \$uri/ /index.html =404;
  }
}
}" > nginx.conf
sudo cp nginx.conf /etc/nginx/

sudo ufw allow 'Nginx HTTP'
sudo systemctl enable --now nginx
