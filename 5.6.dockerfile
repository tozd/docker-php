FROM registry.gitlab.com/tozd/docker/nginx-cron:ubuntu-jammy

ENV PHP_FCGI_CHILDREN=2
ENV PHP_FCGI_MAX_REQUESTS=1000

# /var/lib/php is not owned by fcgi-php, but it is world writable and has a sticky bit.

RUN apt-get update -q -q && \
  apt-get install software-properties-common language-pack-en-base --yes --force-yes && \
  LC_ALL=en_US.UTF-8 add-apt-repository --yes ppa:ondrej/php && \
  apt-get update -q -q && \
  apt-get install php5.6-cgi php5.6-cli php5.6-pgsql php5.6-mysql php5.6-gd adduser --yes --force-yes && \
  adduser --system --group fcgi-php --home /var/lib/php && \
  for file in /etc/php/5.6/mods-available/*.ini; do phpenmod $(basename -s .ini "$file"); done && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc /etc
COPY ./php /etc/php/5.6
