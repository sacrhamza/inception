#!/usr/bin/env bash

set -e

if [[ -z "${DOMAIN_NAME}" ]]
then
  exit 1
fi

echo "CREATING SELF SIGNED CERTIFICATE: $DOMAIN_NAME"
openssl req -x509 -key ssl/private/server.key -out ssl/certs/certificate.pem -subj "/C=US/ST=ls/L=hey/O=hey/CN=${DOMAIN_NAME}"

exec nginx -g 'daemon off;'
