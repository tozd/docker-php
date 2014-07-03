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
 chmod 755 /etc/service/php/run && \
 apt-get install nullmailer --no-install-recommends --yes --force-yes && \
 mkdir /etc/service/nullmailer && \
 /bin/echo -e '#!/bin/sh' > /etc/service/nullmailer/run && \
 /bin/echo -e 'if [ ! -p /var/spool/nullmailer/trigger ]; then rm -f /var/spool/nullmailer/trigger; mkfifo /var/spool/nullmailer/trigger; fi' >> /etc/service/nullmailer/run && \
 /bin/echo -e 'chown mail:root /var/spool/nullmailer/trigger' >> /etc/service/nullmailer/run && \
 /bin/echo -e 'chmod 0622 /var/spool/nullmailer/trigger' >> /etc/service/nullmailer/run && \
 /bin/echo -e "if [ \"\$ADMINADDR\" ]; then echo \"\$ADMINADDR\" > /etc/nullmailer/adminaddr; fi" >> /etc/service/nullmailer/run && \
 /bin/echo -e "if [ \"\$REMOTES\" ]; then echo \"\$REMOTES\" > /etc/nullmailer/remotes; fi" >> /etc/service/nullmailer/run && \
 /bin/echo -e 'exec chpst -u mail:mail /usr/sbin/nullmailer-send 2>&1' >> /etc/service/nullmailer/run && \
 chown root:root /etc/service/nullmailer/run && \
 chmod 755 /etc/service/nullmailer/run && \
 mkdir /etc/service/nullmailer/log && \
 mkdir /var/log/nullmailer && \
 /bin/echo -e '#!/bin/sh' > /etc/service/nullmailer/log/run && \
 /bin/echo -e 'exec chpst -u nobody:nogroup svlogd -tt /var/log/nullmailer' >> /etc/service/nullmailer/log/run && \
 chown root:root /etc/service/nullmailer/log/run && \
 chmod 755 /etc/service/nullmailer/log/run && \
 chown nobody:nogroup /var/log/nullmailer

COPY ./etc/fastcgi_php /etc/nginx/fastcgi_php
