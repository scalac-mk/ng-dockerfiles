FROM node:8

RUN apt-get update && apt-get install -y apt-transport-https

## YARN
RUN \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nginx yarn

ENV APP_HOME /app
ENV PATH $PATH:$APP_HOME/node_modules/.bin

## Dumb-init, for 1 pid issue
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb && \
  dpkg -i dumb-init_1.2.0_amd64.deb && \
  rm -f dumb-init_1.2.0_amd64.deb

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD nginx.conf /etc/nginx/nginx.conf
ADD app.conf /etc/nginx/sites-enabled/default

ONBUILD ADD yarn?lock package?json $APP_HOME/
