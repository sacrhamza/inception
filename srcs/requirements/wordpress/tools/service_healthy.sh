#!/usr/bin/env bash

set -e 

SECRETS_FILE="/run/secrets/wordpress_secrets"

source "${SECRETS_FILE}"

wp --allow-root  --path=/var/www/wordpress user exists "${WP_ADMIN_USER}" 1> /dev/null 2> /dev/null
wp --allow-root --path=/var/www/wordpress user exists "normaluser" 1> /dev/null 2> /dev/null
