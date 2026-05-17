#!bin/bash

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 364 -newkey rsa:2048 -keyout /etc/nginx/ssl/shadria.key -out /etc/nginx/ssl/shadria.crt -subj "/C=MA/L=KHOURIBGA/O=1337/CN=shadria"

nginx -g "daemon off;"

