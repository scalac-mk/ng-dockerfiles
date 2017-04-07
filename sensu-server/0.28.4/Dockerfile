FROM quay.io/netguru/ng-ruby:2.2.3
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

CMD ["/sbin/my_init"]

ENV SENSU_VERSION=0.28.4

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN sh -c 'wget -q https://sensu.global.ssl.fastly.net/apt/pool/trusty/main/s/sensu/sensu_0.28.4-1_amd64.deb -O /tmp/sensu.deb' \
  && dpkg -i /tmp/sensu.deb \
  && rm /tmp/sensu.deb

ENV REDIS_URL=redis://redis:6379/0

ADD sensu-server.sh /etc/service/sensu-server/run
ADD sensu-api.sh /etc/service/sensu-api/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /etc/sensu

RUN sensu-install -p slack
RUN sensu-install -p pagerduty

EXPOSE 4567
