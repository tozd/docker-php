FROM tozd/nginx-cron:ubuntu-xenial

ENV FCGI_HOST 127.0.0.1
ENV FCGI_PORT 9000
ENV PHP_FCGI_CHILDREN 2
ENV PHP_FCGI_MAX_REQUESTS 1000

# /var/lib/php is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
 apt-get install language-pack-en-base --yes && \
 LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \
 apt-get update -q -q && \
 apt-get install php7.2-cgi php7.2-cli php7.2-pgsql php7.2-mysql php7.2-gd adduser --yes && \
 adduser --system --group fcgi-php --home /var/lib/php && \
 for file in /etc/php/7.2/mods-available/*.ini; do phpenmod $(basename -s .ini "$file"); done

COPY ./etc /etc
COPY ./php /etc/php/7.2
