FROM ubuntu:16.04
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

ENV BASEIMAGE_VERSION 0.10.1

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

## Basic required tools and most common rails dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  apt-transport-https ca-certificates \
  software-properties-common file \
  curl wget git make \
  less psmisc \
  vim-nox vim-rails \
  libmysqlclient-dev libpq-dev imagemagick libmagickwand-dev libmagickcore-dev \
  language-pack-en \
  dnsutils inetutils-*

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

## NodeJS 6.x
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g bower && \
  echo '{ "allow_root": true, "interactive": false }' > /root/.bowerrc && \
  echo "  +++  Nodejs (`node --version`) and NPM (`npm --version`) have been installed!"

## YARN
RUN \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

## Dumb-init, for 1 pid issue
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb && \
  dpkg -i dumb-init_1.2.0_amd64.deb && \
  rm -f dumb-init_1.2.0_amd64.deb

## Ruby install
RUN \
  cd /tmp && \
  wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz && \
  tar -xzvf ruby-install-0.6.1.tar.gz && \
  cd ruby-install-0.6.1/ && \
  make install && \
  rm -rf /tmp/ruby-install*

RUN echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc"

ENV APP_HOME '/app'
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

## Cleanup
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
