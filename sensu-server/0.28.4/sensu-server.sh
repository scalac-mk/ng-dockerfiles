#!/bin/bash

exec /opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-server -d -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -l /var/log/sensu/sensu-server.log -L info
