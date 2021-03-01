#!/bin/sh

DHPARAM_PATH=/etc/nginx/ssl/keys/dhparam.pem
DHPARAM_SIZE=2048

if [[ ! -f "${DHPARAM_PATH}" ]]; then
    openssl dhparam -out "${DHPARAM_PATH}" "${DHPARAM_SIZE}"
fi
