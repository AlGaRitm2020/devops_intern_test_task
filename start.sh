#!/bin/bash
set -e

# Создаём директорию для php-fpm
mkdir -p /run/php-fpm

# Инициализируем MariaDB, если ещё не сделано
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Запускаем MariaDB
mariadbd --user=mysql --bind-address=127.0.0.1 &
sleep 5

# Инициализируем нашу БД
mysql -u root < /tmp/init.sql

# Запускаем PHP-FPM на 127.0.0.1:9000 (вместо сокета)
php-fpm -D --fpm-config /etc/php-fpm.d/www.conf

# Запускаем Nginx
nginx -g 'daemon off;'
