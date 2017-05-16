FROM quay.io/netguru/baseimage:0.10.0

## Create new User
RUN useradd -ms /bin/bash rails

ENV RUBY_VERSION ruby2.3
ENV BUNDLER_VERSION 1.12.5

ENV GEM_HOME /gems
ENV BUNDLE_APP_CONFIG $GEM_HOME

ENV PATH $GEM_HOME/bin:$PATH

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN \
  apt-get update && \
  apt-get install -y build-essential bison openssl libreadline6 \
    libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool \
    libgmp-dev && \
  apt-get install -y $RUBY_VERSION $RUBY_VERSION-dev && \
  ruby-switch --set $RUBY_VERSION && \
  gem install bundler --version "$BUNDLER_VERSION" && \
  bundle config --global path "$GEM_HOME" && \
  bundle config --global bin "$GEM_HOME/bin" && \
  bundle config --global frozen 1

ENV RAILS_ENV production
ENV TERM xterm

## Allow rails user to write to /gems and /app
RUN chown -R rails:root /gems
RUN chown -R rails:root /app

RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Switch to rails by default
USER rails
