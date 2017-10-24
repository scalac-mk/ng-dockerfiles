FROM quay.io/netguru/baseimage:0.10.1
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

RUN sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

## Install latest sensu
RUN sh -c 'wget -q https://repositories.sensuapp.org/apt/pool/xenial/main/s/sensu/sensu_1.1.1-1_amd64.deb -O /tmp/sensu.deb' \
  && dpkg -i /tmp/sensu.deb \
  && rm /tmp/sensu.deb

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /etc/sensu

RUN sensu-install -p slack
RUN sensu-install -p pagerduty
