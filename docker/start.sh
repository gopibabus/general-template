#!/usr/bin/env bash

set -e

env=${APP_ENV:-production}
role=${CONTAINER_ROLE:-app}

echo "The environment is $env"

if [ "$env" != "local" ]; then

    echo "Cache Configuration Info"
    (
        cd /var/www/html &&
        php spark cache:info
    )

    # echo "Removing XDebug"
    # rm -rf /usr/local/etc/php/conf.d/{docker-php-ext-xdebug.ini, xdebug.ini}
fi

if [ "$role" = "app" ]; then
    exec apache2-foreground
else
    echo "Could not match the container role \"$role\""
    exit 1
fi