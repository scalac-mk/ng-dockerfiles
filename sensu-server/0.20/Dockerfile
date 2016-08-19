FROM quay.io/netguru/baseimage
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

CMD ["/sbin/my_init"]

ENV SENSU_VERSION=0.20.3

RUN sh -c 'wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | apt-key add -'
RUN sh -c 'echo deb http://repos.sensuapp.org/apt sensu main > /etc/apt/sources.list.d/sensu.list'

RUN apt-get update -qq
RUN apt-get install -y sensu=$SENSU_VERSION-1
RUN apt-get install -y ruby-dev

ENV REDIS_URL=redis://redis:6379/0

ADD sensu-server.sh /etc/service/sensu-server/run
ADD sensu-api.sh /etc/service/sensu-api/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /etc/sensu


RUN gem install sensu-plugins-slack
RUN gem install sensu-plugins-pagerduty

EXPOSE 4567
