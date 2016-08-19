# Uchiwa dashboard

Quay repository: https://quay.io/repository/netguru/uchiwa

## Building images

`docker build -t quay.io/netguru/uchiwa:VERSION .`

## Properly tag images

Tag command: `docker tag -f quay.io/netguru/uchiwa:EXISTING_TAG quay.io/netguru/uchiwa:NEW_TAG`
Tag with minor, major and latest tag. Example if latest uchiwa is `0.12.1` then tag the latest build with `0.12.1`, `0.12` and `latest`. Aftar tagging, push it to quay: `docker push quay.io/netguru/uchiwa`

## Example ansible script how to use this image

```
- name: start uchiwa container
  docker:
    name: uchiwa
    image: quay.io/netguru/uchiwa:0.14.2
    state: started
    restart_policy: always
    volumes:
      - "/etc/sensu/uchiwa.json:/etc/sensu/uchiwa.json:ro"
```
