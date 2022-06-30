# Nginx for Docker

Docker image for Nginx 1.20 (stable).

- TLS 1.3 only
- Handler for unknown domains
- Generates self-signed certificate for default server
- Generates `dhparam.pem` of size 2048
- Generates fallback self-signed certificate used by fallback HTTPS server

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
