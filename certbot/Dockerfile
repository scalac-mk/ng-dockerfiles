FROM alpine:3.4

RUN apk add --update  \
  python python-dev py-pip \
  gcc musl-dev linux-headers \
  augeas-dev openssl-dev libffi-dev ca-certificates \
  && rm -rf /var/cache/apk/*

RUN pip install --upgrade pip
RUN pip install -U letsencrypt

ADD issue /usr/local/bin/issue
