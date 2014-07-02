FROM cloyne/nginx

MAINTAINER Mitar <mitar.docker@tnode.com>

ENV FCGI_HOST 127.0.0.1
ENV FCGI_PORT 9000
ENV PHP_FCGI_CHILDREN 2
ENV PHP_FCGI_MAX_REQUESTS 1000

RUN apt-get update -q -q && \
 apt-get install php5-cgi php5-pgsql adduser --yes --force-yes && \
 adduser --system --group fcgi-php --home /var/lib/php5 && \
 mkdir /etc/service/php && \
 /bin/echo -e '#!/bin/sh' > /etc/service/php/run && \
 /bin/echo -e 'echo "fastcgi_pass $FCGI_HOST:$FCGI_PORT;" > /etc/nginx/fastcgi_host' >> /etc/service/php/run && \
 /bin/echo -e 'exec chpst -u fcgi-php:fcgi-php /usr/bin/php-cgi -q -b $FCGI_HOST:$FCGI_PORT 2>&1' >> /etc/service/php/run && \
 chown root:root /etc/service/php/run && \
 chmod 755 /etc/service/php/run

COPY ./etc/fastcgi_php /etc/nginx/fastcgi_php
