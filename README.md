# Nginx for Docker

Docker image for Nginx 1.22 (stable).

- TLS 1.3 only
- Handler for unknown domains
- Generates self-signed certificate for default server
- Generates `dhparam.pem` of size 2048
- Generates fallback self-signed certificate used by fallback HTTPS server

## Example

```nginx
server {
    listen                  [::]:80 deferred;
    listen                  80 deferred;

    server_name             example.com;

    return 301 https://$host$request_uri;
}

server {
    listen                  [::]:443 ssl http2;
    listen                  443 ssl http2;

    server_name             example.com;
    root                    /srv;

    include                 snippets/tls/enable.conf;
    include                 snippets/tls/ocsp.conf;

    ssl_certificate         ssl/certs/example.com.pem;
    ssl_certificate_key     ssl/keys/example.com.pem;

    location / {
        index               index.html;
        try_files           $uri =404;
    }
}
```

## Snippets
| Snippet                 | Description                                |
| ----------------------- | ------------------------------------------ |
| `log_no_favicon.conf`   | Disable logging of `/favicon.ico` requests |
| `log_no_robots.conf`    | Disable logging of `/robots.txt` requests  |

### TLS
| Snippet       | Description                                           |
| ------------- | ----------------------------------------------------- |
| `enable.conf` | Enable SSL                                            |
| `ocsp.conf`   | Enable OCSP stapling                                  |

### Headers
| Snippet         | Description                                           |
| --------------- | ----------------------------------------------------- |
| `hsts.conf`     | Forces HTTPS                                          |
| `robots.conf`   | Disallow internet robots to follow and index the page |
| `security.conf` | Various security headers                              |
