ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}

LABEL maintainer="Richard Boldiš <richard@boldis.dev>"

#
# Packages
#

RUN apk add --no-cache --update openssl

#
# Configuration
#

# Replace default nginx configuration
RUN rm -f /etc/nginx/conf.d/default.conf \
 && mkdir -p /etc/nginx/ssl/certs /etc/nginx/ssl/keys \
 && chmod 0700 /etc/nginx/ssl/keys
COPY --chown=root:root ./config/nginx.conf /etc/nginx/nginx.conf
COPY --chown=root:root ./config/default.conf /etc/nginx/conf.d/default.conf

# Snippets
COPY --chown=root:root ./config/snippets /etc/nginx/snippets

#
# Entrypoints
#

# Entrypoint for dhparam.pem generation
COPY --chown=root:root ./entrypoint/10-generate-dhparam.sh /docker-entrypoint.d/10-generate-dhparam.sh

# Entrypoint for fallback self-signed certificate
COPY --chown=root:root ./entrypoint/20-generate-fallback-certificate.sh /docker-entrypoint.d/20-generate-fallback-certificate.sh

# Add execute permission to entrypoint scripts
RUN find /docker-entrypoint.d -mindepth 1 -maxdepth 1 -type f -name '*.sh' -exec chmod u+x {} \;
