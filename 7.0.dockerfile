FROM tozd/nginx-cron:ubuntu-xenial

ENV FCGI_HOST 127.0.0.1
ENV FCGI_PORT 9000
ENV PHP_FCGI_CHILDREN 2
ENV PHP_FCGI_MAX_REQUESTS 1000

# /var/lib/php is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
 apt-get install php7.0-cgi php7.0-cli php7.0-pgsql php7.0-mysql php7.0-gd adduser --yes --force-yes && \
 adduser --system --group fcgi-php --home /var/lib/php && \
 for file in /etc/php/7.0/mods-available/*.ini; do phpenmod $(basename -s .ini "$file"); done && \
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
COPY ./php /etc/php/7.0
