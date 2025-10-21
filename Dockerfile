# берем базовый образ алмалинукс 9 (opensource rpm-based) (L)
FROM almalinux:9

# устанавливаем необходимые инструменты в контейнер (E, M, P) через менеджер пакетов альмы
RUN dnf install -y nginx php-fpm php-mysqlnd mariadb-server mariadb && \
    dnf clean all

# копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/nginx.conf
# копируем php файл который прикручен к корню веб приложения 
COPY index.php /var/www/html/index.php
# копируем файл для иницилизирующего запроса sql
COPY init.sql /tmp/init.sql
# копируем bash скрипт который создает БД, и запускает php с nginx
COPY start.sh /start.sh
# копируем переопределенный www.conf
COPY www.conf /etc/php-fpm.d/www.conf

# настраиваем права на скрипт, php, /var/www/html
RUN chmod +x /start.sh && \
    chown -R nginx:nginx /var/lib/php/session && \
    mkdir -p /var/www/html && chown -R nginx:nginx /var/www/html

# используем внутренний порт докера 80 ( в него мы проксируем с внешнего 8080)
EXPOSE 80

# запускаем скрипт 
CMD ["/start.sh"]
