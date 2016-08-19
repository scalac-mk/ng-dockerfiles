FROM jwilder/nginx-proxy

RUN apt-get update \
  && apt-get install -y inotify-tools ruby

ENV APP_HOME /app
ENV HOME /root
ENV DYNAMICS /etc/nginx/conf.d/dynamics

RUN mkdir -p $DYNAMICS

COPY inotify.rb Procfile $APP_HOME/
COPY nginx.conf /etc/nginx/nginx.conf
