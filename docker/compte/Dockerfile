FROM php:5.6-apache

ARG GIT_REPO

ENV PHP_TIMEZONE UTC
ENV PHP_MEMORY_LIMIT 32M
ENV MAX_UPLOAD 8M

RUN apt-get update && \
    apt-get install -y libpng12-dev libjpeg-dev libpq-dev cron wget curl git && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
    docker-php-ext-install gd && \
    # TODO: use mysqli instead
    docker-php-ext-install mysql && \
    apt-get purge -y libpng12-dev libjpeg-dev

RUN git clone ${GIT_REPO} /var/www/html && \
    find /var/www/html -name .git | xargs rm -rf && \
    apt-get purge -y git

COPY php.ini /usr/local/etc/php/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
