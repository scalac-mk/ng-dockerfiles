FROM debian:latest

RUN apt-get -y update
RUN apt-get install -y gnupg
RUN apt-get install -y curl
RUN apt-get install -y python python-dev python-distribute python-pip
RUN apt-get install -y p7zip-full

RUN curl https://sdk.cloud.google.com | bash

ADD start.sh /start.sh
ADD encrypt_and_upload.sh /encrypt_and_upload.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
