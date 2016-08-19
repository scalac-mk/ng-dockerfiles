# nginx_proxy

A fork from jwilder/nginx_proxy with added file watcher to forego in Procfile. Every time file changes inside /etc/nginx/conf.d/dynamics folder (inside container), it will trigger nginx reload

Quay repository: https://quay.io/repository/netguru/nginx_proxy

## Versions

* `0.4.0` (built from [jwilder/nginx-proxy#0.4.0](https://github.com/jwilder/nginx-proxy/tree/0.4.0))

## Usage of image

`docker run -d -p 80:80 -p 443:443 -v /var/run/docker.sock:/tmp/docker.sock:ro -v /etc/nginx/conf.d/dynamics/:/etc/nginx/conf.d/dynamics [-v /etc/nginx/docker-nginx.conf:/etc/nginx/nginx.conf] quay.io/netguru/nginx_proxy:VERSION`


