FROM nginx:1.18-alpine

WORKDIR /srv

RUN mkdir -p /etc/nginx/ssl/certs /etc/nginx/ssl/keys && \
    chmod 0600 /etc/nginx/ssl/keys && \
    rm -f /etc/nginx/conf.d/* && \
    rm -rf /usr/share/nginx/html && \
    rm -f /docker-entrypoint.d/*

RUN apk add --update --no-cache openssl

# Script to generate default nginx certificate 
COPY ./scripts/generate_default_certificate.sh /docker-entrypoint.d/generate_default_certificate.sh
COPY ./scripts/generate_dhparam.sh /docker-entrypoint.d/generate_dhparam.sh

# Main Nginx config
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Default nginx server
COPY ./config/default.conf /etc/nginx/conf.d/default.conf

# Server configuration snippets
RUN mkdir -p /etc/nginx/snippets
COPY ./config/security_headers.conf /etc/nginx/snippets/security_headers.conf
