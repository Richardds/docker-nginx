#!/bin/sh

DHPARAM_PATH=/etc/nginx/ssl/keys/dhparam.pem

if [[ ! -f "${DHPARAM_PATH}" ]]; then
    openssl dhparam -out "${DHPARAM_PATH}" 4096
fi
