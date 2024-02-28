#!/bin/bash

if [ -f vendor/autoload.php ]; then
    composer install
fi

if [ ! -f ".env" ]; then
    echo "Creating env file automatically for $APP_ENV"
    cp env.example .env
else
   echo "env file found"
fi

# need to investigate here migration always failing
# may be because of ${}
php artisan migrate
php artisan key:generate
php artisan optimize:clear

php artisan serve --port=$PORT --host=0.0.0.0 --env=.env
exec docker-php-entrypoint "$@"
