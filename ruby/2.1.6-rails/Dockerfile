FROM quay.io/netguru/baseimage:0.9.18.2

ENV RUBY_VERSION 2.1.6
ENV BUNDLER_VERSION 1.12.5

ENV GEM_HOME /gems
ENV BUNDLE_APP_CONFIG $GEM_HOME

ENV PATH $GEM_HOME/bin:$PATH

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get update \
  && ruby-install --system --cleanup ruby $RUBY_VERSION \
  && apt-get install -y libmysqlclient-dev libpq-dev imagemagick libmagickwand-dev libmagickcore-dev \
  && gem install bundler --version "$BUNDLER_VERSION" \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && bundle config --global frozen 1

RUN bootstrap passenger node

# for pid 1 issue
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.3/dumb-init_1.0.3_amd64.deb
RUN dpkg -i dumb-init_*.deb

# forego, if you want to have heroku-style Procfile processes running
RUN curl https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz | tar -zxC /usr/local/bin

ENV TERM xterm
ENV APP_HOME /app
ENV RAILS_ENV production

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
