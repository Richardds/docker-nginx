#!/bin/sh
# vim:sw=4:ts=4:et

#
# Generates default (fallback) self-signed certificate
#
# Author: Richard Boldiš <richard@boldis.dev>
#

set -e

CERTIFICATE_PATH=/etc/nginx/ssl/certs/default.pem
PRIVATEKEY_PATH=/etc/nginx/ssl/keys/default.pem
SUBJECT=default

if [ ! -f "${CERTIFICATE_PATH}" ]; then
    openssl req \
        -x509 \
        -newkey rsa:2048 \
        -nodes \
        -sha256 \
        -keyout "${PRIVATEKEY_PATH}" \
        -out "${CERTIFICATE_PATH}" \
        -days 3650 \
        -subj "/CN=${SUBJECT}"

    chmod 0600 "${PRIVATEKEY_PATH}"
fi
