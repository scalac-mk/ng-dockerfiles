# certbot

A simple dockerfile which will create a letsencrypt certificate using "webroot" plugin. This assumes you already have nginx or apache configured which exposes a directory on host, that can be mapped into this container.

## Usage

Example use:

```
docker run -v acme-webroot:/webroot -v /etc/letsencrypt:/etc/letsencrypt -e DOMAIN=example.com -e EMAIL=example@email.com quay.io/netguru/letsencrypt:latest issue
```

## TODO

* automatic renewal
