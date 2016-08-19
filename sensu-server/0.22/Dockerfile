FROM quay.io/netguru/ng-ruby:2.2.3
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

CMD ["/sbin/my_init"]

ENV SENSU_VERSION=0.22.0

RUN sh -c 'wget -q http://repositories.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -'
RUN sh -c 'echo deb http://repositories.sensuapp.org/apt sensu main > /etc/apt/sources.list.d/sensu.list'

RUN apt-get update -qq
RUN apt-get install -y sensu=$SENSU_VERSION-1

ENV REDIS_URL=redis://redis:6379/0

ADD sensu-server.sh /etc/service/sensu-server/run
ADD sensu-api.sh /etc/service/sensu-api/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /etc/sensu


RUN sensu-install -p slack
RUN sensu-install -p pagerduty

EXPOSE 4567
