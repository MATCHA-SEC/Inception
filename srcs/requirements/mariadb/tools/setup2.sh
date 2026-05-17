#!/bin/bash

mysql_install_db

mysqld_safe &


sleep 5

mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"


mysqladmin shutdown

mysqld
