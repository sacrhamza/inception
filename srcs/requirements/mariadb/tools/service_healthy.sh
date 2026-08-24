#!/usr/bin/env bash

set -e

source /tmp/file.sh

# check if there is the user and the database
mariadb-check --user="${MARIADB_USER}" -B "${DATABASE_NAME}" --password="${MARIADB_PASSWORD}";
