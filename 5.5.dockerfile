FROM registry.gitlab.com/tozd/docker/nginx-cron:ubuntu-trusty

ENV PHP_FCGI_CHILDREN=2
ENV PHP_FCGI_MAX_REQUESTS=1000

# /var/lib/php5 is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
  apt-get install php5-cgi php5-cli php5-pgsql php5-mysql php5-gd adduser --yes --force-yes && \
  adduser --system --group fcgi-php --home /var/lib/php5 && \
  for file in /etc/php5/mods-available/*.ini; do php5enmod $(basename -s .ini "$file"); done && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
COPY ./php /etc/php5
