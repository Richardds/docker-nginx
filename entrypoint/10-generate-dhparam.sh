#!/bin/sh

#
# Generates the Diffie-Hellman key agreement parameters
#
# Author: Richard Boldiš <richard@boldis.dev>
#

DHPARAM_PATH=/etc/nginx/ssl/keys/dhparam.pem
DHPARAM_SIZE=2048

if [ ! -f "${DHPARAM_PATH}" ]; then
    echo "Generating Diffie-Hellman key..."

    openssl dhparam -out "${DHPARAM_PATH}" "${DHPARAM_SIZE}" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "Diffie-Hellman key generated successfully"
    else
        >&2 echo "Failed to generate Diffie-Hellman key"
        exit 1
    fi

    chmod 0600 "${DHPARAM_PATH}"
fi
