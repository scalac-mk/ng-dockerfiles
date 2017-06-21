FROM node:8

RUN apt-get update && apt-get install -y nginx

ENV APP_HOME /app
ENV PATH $PATH:$APP_HOME/node_modules/.bin

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb
RUN dpkg -i dumb-init_1.2.0_amd64.deb && rm -rf dumb-init_1.2.0_amd64.deb

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN npm install -g yarn --silent 2>&1 | cat

ADD nginx.conf /etc/nginx/nginx.conf
ADD app.conf /etc/nginx/sites-enabled/default

ONBUILD ADD yarn?lock package?json $APP_HOME/
