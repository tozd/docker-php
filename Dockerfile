FROM tozd/nginx

ENV FCGI_HOST 127.0.0.1
ENV FCGI_PORT 9000
ENV PHP_FCGI_CHILDREN 2
ENV PHP_FCGI_MAX_REQUESTS 1000

ENV ADMINADDR=
ENV REMOTES=

# /var/lib/php5 is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
 apt-get install nullmailer --no-install-recommends --yes --force-yes && \
 apt-get install cron php5-cgi php5-cli php5-pgsql php5-mysql php5-gd adduser --yes --force-yes && \
 adduser --system --group fcgi-php --home /var/lib/php5 && \
 mkdir -m 700 /var/spool/nullmailer.orig && \
 mv /var/spool/nullmailer/* /var/spool/nullmailer.orig/

COPY ./etc /etc
