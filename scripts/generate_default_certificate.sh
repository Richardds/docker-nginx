#!/bin/sh

CERTIFICATE_PATH=/etc/nginx/ssl/certs/default.pem
PRIVATEKEY_PATH=/etc/nginx/ssl/keys/default.pem
SUBJECT=default

if [[ ! -f "${CERTIFICATE_PATH}" ]]; then
    openssl req \
        -x509 \
        -newkey rsa:4096 \
        -nodes \
        -sha256 \
        -keyout "${PRIVATEKEY_PATH}" \
        -out "${CERTIFICATE_PATH}" \
        -days 3650 \
        -subj "/CN=${SUBJECT}"
fi
