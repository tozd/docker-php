# tozd/php

<https://gitlab.com/tozd/docker/php>

Image extending [tozd/nginx-cron](https://gitlab.com/tozd/docker/nginx-cron) image to add [PHP](https://secure.php.net/)
and PHP FCGI daemon.

Different Docker tags provide different PHP versions.

If you are extending this image, you can add a script `/etc/service/php/run.initialization`
which will be run at a container startup, after the container is initialized, but before the
PHP FCGI daemon is run.

All images are rebuild daily to get any latest (security) updates from
the underlying distribution.
If you do the same in your image (which extends any of these images), you will
get those updates as well.