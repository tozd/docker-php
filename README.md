# tozd/php

<https://gitlab.com/tozd/docker/php>

Available as:

- [`tozd/php`](https://hub.docker.com/r/tozd/php)
- [`registry.gitlab.com/tozd/docker/php`](https://gitlab.com/tozd/docker/php/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← [`tozd/nginx`](https://gitlab.com/tozd/docker/nginx) ← [`tozd/nginx-mailer`](https://gitlab.com/tozd/docker/nginx-mailer) ← [`tozd/nginx-cron`](https://gitlab.com/tozd/docker/nginx-cron) ← `tozd/php`

## Tags

- `5.5`: PHP 5.5
- `5.6`: PHP 5.6
- `7.0`: PHP 7.0
- `7.2`: PHP 7.2
- `7.4`: PHP 7.4
- `8.0`: PHP 8.0
- `8.2`: PHP 8.2

## Variables

- `PHP_FCGI_CHILDREN`: How many PHP workers to create. Default is 2.
- `PHP_FCGI_MAX_REQUESTS`: How many requests can each worker handle before it is restarted.
  Default is 1000.

## Description

Image extending [tozd/nginx-cron](https://gitlab.com/tozd/docker/nginx-cron) image to add [PHP](https://secure.php.net/)
and PHP FCGI daemon. This means that it also includes an e-mail mailer and can run cron jobs.

Different Docker tags provide different PHP versions.

If you are extending this image, you can add a script `/etc/service/php/run.initialization`
which will be run at a container startup, after the container is initialized, but before the
PHP FCGI daemon is run.

To get nginx to serve your PHP files, you can configure it by copying the following configuration
to `/etc/nginx/sites-enabled/default`:

```nginx
server {
    listen 80 default_server;
    server_name _;
    access_log /var/log/nginx/default_access.log json;

    root /path/to/your/php/code;

    location ~ /\. {
        return 403;
    }

    location ~ \.php$ {
        try_files $uri =404;
        include fastcgi_php;
    }
}
```

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-php),
if you need to fork the project there.
