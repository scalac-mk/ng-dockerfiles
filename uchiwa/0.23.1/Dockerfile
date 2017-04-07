FROM quay.io/netguru/baseimage
MAINTAINER Jacek Jakubik <jacek.jakubik@netguru.pl>

CMD ["/sbin/my_init"]

ENV UCHIWA_VERSION=0.23.1

RUN sh -c 'wget -q http://dl.bintray.com/palourde/uchiwa/uchiwa_$UCHIWA_VERSION-1_amd64.deb -O /tmp/uchiwa.deb'
RUN dpkg -i /tmp/uchiwa.deb

ADD uchiwa.sh /etc/service/uchiwa/run

EXPOSE 3000
