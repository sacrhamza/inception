#!/usr/bin/env bash

set -e

SECRETS_FILE="/run/secrets/database_secrets"

if [ ! -f "$SECRETS_FILE" ]
then
  exit 1
fi

source "$SECRETS_FILE"

# check if there is the user and the database
mariadb-check --user="${MARIADB_USER}" -B "${DATABASE_NAME}" --password="${MARIADB_USER_PASSWORD}";
