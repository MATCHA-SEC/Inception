#!/bin/bash

wp core download --allow-root
sleep 5

wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$DB_HOST" --allow-root
sleep 5

wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_MAIL"  --allow-root
sleep 5
wp user create "$WP_USER" "$WP_MAIL" --role=author --user_pass="$WP_PASSWORD" --allow-root

/usr/sbin/php-fpm7.4 -F
