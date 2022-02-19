# Nginx

Docker image for Nginx 1.20 (stable).

- Generates self-signed certificate for default server
- Generates custom `dhparam.pem` of size 2048
- Generates fallback self-signed certificate used by fallback HTTPS server

## Snippets
| Snippet name            | Description                                 |
|-------------------------|---------------------------------------------|
| `security_headers.conf` | Enables various security headers            |
| `ignore_favicon.conf`   | Disables logging of `/favicon.ico` requests |
| `ignore_robots.conf`    | Disables logging of `/robots.txt` requests  |
