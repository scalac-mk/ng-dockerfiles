FROM ruby:2.1.10

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get update \
  && apt-get install -y --force-yes cron


## Install passenger
RUN set -ex \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 \
  && apt-get install -y apt-transport-https ca-certificates \
  # Add our APT repository
  && sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list' \
  && apt-get update \
  # Install Passenger
  && apt-get install -y passenger

## Install nodejs
COPY install_node.sh /tmp/install_node.sh
RUN sh /tmp/install_node.sh

## for pid 1 issue
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.3/dumb-init_1.0.3_amd64.deb
RUN dpkg -i dumb-init_*.deb

## forego
RUN curl https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz | tar -zxC /usr/local/bin

ENV TERM xterm
ENV APP_HOME /app
ENV RAILS_ENV production

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
