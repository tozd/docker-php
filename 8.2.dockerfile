FROM registry.gitlab.com/tozd/docker/nginx-cron:ubuntu-noble

ENV PHP_FCGI_CHILDREN=2
ENV PHP_FCGI_MAX_REQUESTS=1000

# /var/lib/php is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
  apt-get install software-properties-common language-pack-en-base --yes --force-yes && \
  LC_ALL=en_US.UTF-8 add-apt-repository --yes ppa:ondrej/php && \
  apt-get update -q -q && \
  apt-get install php8.2-cgi php8.2-cli php8.2-pgsql php8.2-mysql php8.2-gd adduser --yes --force-yes && \
  adduser --system --group fcgi-php --home /var/lib/php && \
  for file in /etc/php/8.2/mods-available/*.ini; do phpenmod $(basename -s .ini "$file"); done && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/nginx /etc/nginx
COPY ./etc/service/php /etc/service/php
COPY ./php /etc/php/8.2
