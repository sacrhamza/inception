#!/usr/bin/env bash

set -e

source /tmp/file.sh

service mariadb start

echo "creating user and database and set privileges..."
echo "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};" | mariadb
echo "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';" | mariadb
echo "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MARIADB_USER}'@'%';" | mariadb

# until mariadb-admin ping && [[ -S /run/mysqld/mysqld.sock ]]
# do
#   sleep 0.01
# done
sleep 1
service mariadb stop

exec mariadbd-safe
