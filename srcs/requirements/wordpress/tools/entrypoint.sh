#!/usr/bin/env bash

PATH+=":/usr/local/bin"

set -e 

SECRET_DIR="/run/secrets"
DATABASE_SECRETS="${SECRET_DIR}/database_secrets"
WORDPRESS_SECRETS="${SECRET_DIR}/wordpress_secrets"

if [[ ! -f ${DATABASE_SECRETS} ]] || [[ ! -f ${WORDPRESS_SECRETS} ]]
then
  echo "NO SECRET FILES!!"
  exit 1
fi

source ${DATABASE_SECRETS}
source ${WORDPRESS_SECRETS}


list_of_envs=( "$DOMAIN_NAME"
  "$DATABASE_NAME" "$MARIADB_USER" "$MARIADB_USER_PASSWORD"
  "$WP_ADMIN_USER" "$WP_ADMIN_PASSWORD" "$WP_ADMIN_EMAIL" "$WP_TITLE")

for env in "${list_of_envs[@]}"
do
  if [[ -z "$env" ]] 
  then
    exit 1
  fi
done


if ! wp --allow-root  --path=/var/www/wordpress user exists "${WP_ADMIN_USER}" 1> /dev/null 2> /dev/null
then

  # config for database
  wp --allow-root config create \
    --path=/var/www/wordpress \
    --dbname="$DATABASE_NAME" \
    --dbuser="$MARIADB_USER" \
    --dbpass="$MARIADB_USER_PASSWORD" \
    --dbhost="mariadb:3306"

  # config for website and user
  wp --allow-root core install \
    --path=/var/www/wordpress \
    --url="https://$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"


  # adding a normal user role: subscriber
  wp user create normaluser normal@example.com \
    --path=/var/www/wordpress \
    --role=subscriber \
    --user_pass='normal_user_password' \
    --allow-root
fi

echo "EXECUTING PHP-FPM..."
exec php-fpm8.2  -F
