FROM phusion/baseimage:0.9.18
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

ENV BASEIMAGE_VERSION 0.9.18.2
ENV RUBY_INSTALL_VERSION 0.5.0

## Latest Security Updates
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    git \
    make

RUN cd /tmp \
  && wget -O ruby-install-$RUBY_INSTALL_VERSION.tar.gz https://github.com/postmodern/ruby-install/archive/v$RUBY_INSTALL_VERSION.tar.gz \
  && tar -xzvf ruby-install-$RUBY_INSTALL_VERSION.tar.gz \
  && cd ruby-install-$RUBY_INSTALL_VERSION \
  && make install

RUN echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc"

RUN apt-get install -y vim-nox vim-rails
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD passenger /opt/passenger
ADD node /opt/node
ADD capybara /opt/capybara
ADD services /opt/services

ADD scripts/on-start /bin/on-start
ADD scripts/run-on-start /bin/run-on-start

ADD scripts/set-timezone /bin/set-timezone
ADD scripts/configure-crontab /bin/configure-crontab

ADD scripts/add-service /bin/add-service
ADD scripts/install-deps /bin/install-deps
ADD scripts/wait-for /bin/wait-for

ADD scripts/bootstrap /bin/bootstrap

ENV APP_HOME '/var/www/app'
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/my_init"]
