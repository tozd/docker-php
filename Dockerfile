FROM cloyne/nginx

MAINTAINER Mitar <mitar.docker@tnode.com>

ENV FCGI_HOST 127.0.0.1
ENV FCGI_PORT 9000
ENV PHP_FCGI_CHILDREN 2
ENV PHP_FCGI_MAX_REQUESTS 1000

RUN apt-get update -q -q && \
 apt-get install php5-cgi php5-pgsql php5-mysql adduser --yes --force-yes && \
 adduser --system --group fcgi-php --home /var/lib/php5 && \
 apt-get install nullmailer --no-install-recommends --yes --force-yes

COPY ./etc /etc
