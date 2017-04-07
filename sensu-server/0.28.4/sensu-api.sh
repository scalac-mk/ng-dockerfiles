#!/bin/bash

exec /opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-api -d -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -l /var/log/sensu/sensu-api.log -L info
