#!/usr/bin/env bash

set -e

SECRET_FILE="/run/secrets/database_secrets"

if [ ! -f "$SECRET_FILE" ]
then
  echo "NO SECRET FILE!"
  exit 1
fi

source "$SECRET_FILE"

list_of_envs=("$DATABASE_NAME" "$MARIADB_USER" "$MARIADB_USER_PASSWORD")


for env in "${list_of_envs[@]}"
do
  if [[ -z "$env" ]] 
  then
    exit 1
  fi
done

service mariadb start

echo "creating user and database and set privileges..."
echo "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};" | mariadb
echo "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';" | mariadb
echo "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MARIADB_USER}'@'%';" | mariadb

# mariadb-admin shutdown

# sleep 2
service mariadb stop

echo "STARTING MARIADB"
exec mariadbd-safe
