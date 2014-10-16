FROM debian:wheezy

MAINTAINER Doug Tangren <d.tangren@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade

RUN apt-get -y --force-yes \
            install supervisor \
            memcached --no-install-recommends

RUN mkdir -p /var/log/supervisor

COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./bin/run /bin/run

EXPOSE 11211

CMD /bin/run

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*