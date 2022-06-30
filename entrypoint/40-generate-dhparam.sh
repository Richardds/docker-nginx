#!/bin/sh
# vim:sw=4:ts=4:et

#
# Generates the Diffie-Hellman parameter
#
# Author: Richard Boldiš <richard@boldis.dev>
#

set -e

DHPARAM_PATH=/etc/nginx/ssl/keys/dhparam.pem
DHPARAM_SIZE="${DHPARAM_SIZE-2048}"

if [ ! -f "${DHPARAM_PATH}" ]; then
    echo "Generating Diffie-Hellman parameter of size ${DHPARAM_SIZE}..."

    openssl dhparam -out "${DHPARAM_PATH}" "${DHPARAM_SIZE}" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "Diffie-Hellman parameter generated successfully"
    else
        >&2 echo "Failed to generate Diffie-Hellman parameter"
        exit 1
    fi

    chmod 0600 "${DHPARAM_PATH}"
fi
