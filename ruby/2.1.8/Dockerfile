FROM quay.io/netguru/baseimage:0.9.18.1

ENV RUBY_VERSION 2.1.8
ENV BUNDLER_VERSION 1.11.2

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_APP_CONFIG $GEM_HOME

ENV PATH $GEM_HOME/bin:$PATH

RUN apt-get update \
  && ruby-install --system --cleanup ruby $RUBY_VERSION \
  && gem install bundler --version "$BUNDLER_VERSION" \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && bundle config --global frozen 1

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TERM=xterm
