# Sensu-server 0.22

## running the image

`docker run -d -v path_to_config_dir:/etc/sensu quay.io/netguru/sensu:0.22`

Where:
* `path_to_config_dir` - path which contains configuration files (`sensu.json`, `api.json`)

## Example ansible script how to run this image

```
- name: run sensu-server container
  docker:
    name: sensu-server
    image: quay.io/netguru/sensu-server:0.22
    state: started
    restart_policy: always
    links:
      - "rabbitmq:rabbitmq"
      - "redis:redis"
    volumes:
      - /etc/sensu:/etc/sensu
```

Where:
* `/etc/sensu` is a place where all the configuration should be
