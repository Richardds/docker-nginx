ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}-alpine

LABEL org.opencontainers.image.title 'Nginx'
LABEL org.opencontainers.image.description 'Nginx with strict configuration and snippets'
LABEL org.opencontainers.image.authors 'Richard Boldiš <richard@boldis.dev>'
LABEL org.opencontainers.image.source https://github.com/Richardds/docker-nginx

#
# Packages
#

# Install openssl for default certificate generation and ca-certificates-bundle
# for up to date bundle of Mozilla certificates
RUN apk add --no-cache --update openssl ca-certificates-bundle \
 && rm -rf /var/cache/apk/*

#
# Configuration
#

# Add snippets from https://github.com/h5bp/server-configs-nginx
ADD --chown=root:root 'https://raw.githubusercontent.com/h5bp/server-configs-nginx/main/mime.types' /etc/nginx/mime.types
ADD --chown=root:root 'https://raw.githubusercontent.com/h5bp/server-configs-nginx/main/h5bp/media_types/character_encodings.conf' /etc/nginx/snippets/charset.conf
ADD --chown=root:root 'https://raw.githubusercontent.com/h5bp/server-configs-nginx/main/h5bp/web_performance/compression.conf' /etc/nginx/snippets/compression.conf
ADD --chown=root:root 'https://raw.githubusercontent.com/h5bp/server-configs-nginx/main/h5bp/web_performance/cache_expiration.conf' /etc/nginx/snippets/cache.conf

# Replace default nginx configuration and add snippets
RUN rm -f /etc/nginx/conf.d/default.conf \
 && mkdir -p /etc/nginx/ssl/certs /etc/nginx/ssl/keys \
 && chmod 0700 /etc/nginx/ssl/keys
COPY --chown=root:root ./config /etc/nginx

#
# Entrypoints
#

# Remove automatic IPv6 script
RUN rm -f /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh

# Add entrypoint scripts
COPY --chown=root:root ./entrypoint /docker-entrypoint.d

# Add execute permission to entrypoint scripts
RUN find /docker-entrypoint.d -mindepth 1 -maxdepth 1 -type f -name '*.sh' -exec chmod u+x {} \;
