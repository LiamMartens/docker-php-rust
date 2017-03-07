FROM alpine:edge
MAINTAINER Liam Martens (hi@liammartens.com)

# add testing branch
RUN echo @testing http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

# add www-data user
RUN adduser -D www-data

# run updates
RUN apk update && apk upgrade

# add packages
RUN apk add tzdata perl curl bash

# install php 7
ENV PHPV=7.1
RUN apk add --update --no-cache \
    php$PHPV-mcrypt@testing \
    php$PHPV-soap@testing \
    php$PHPV-openssl@testing \
    php$PHPV-gmp@testing \
    php$PHPV-pdo_odbc@testing \
    php$PHPV-json@testing \
    php$PHPV-dom@testing \
    php$PHPV-pdo@testing \
    php$PHPV-zip@testing \
    php$PHPV-mysqli@testing \
    php$PHPV-sqlite3@testing \
    php$PHPV-pdo_pgsql@testing \
    php$PHPV-bcmath@testing \
    php$PHPV-opcache@testing \
    php$PHPV-intl@testing \
    php$PHPV-mbstring@testing \
    php$PHPV-sockets@testing \
    php$PHPV-zlib@testing \
    php$PHPV-xml@testing \
    php$PHPV-session@testing \
    php$PHPV-pcntl@testing \
    php$PHPV-gd@testing \
    php$PHPV-odbc@testing \
    php$PHPV-pdo_mysql@testing \
    php$PHPV-pdo_sqlite@testing \
    php$PHPV-gettext@testing \
    php$PHPV-xmlreader@testing \
    php$PHPV-xmlrpc@testing \
    php$PHPV-bz2@testing \
    php$PHPV-iconv@testing \
    php$PHPV-pdo_dblib@testing \
    php$PHPV-curl@testing \
    php$PHPV-ctype@testing \
    php$PHPV-pear@testing \
    php$PHPV-fpm@testing

RUN apk add git alpine-sdk gcc

# create php directory
RUN mkdir -p /etc/php7 /var/log/php7 /usr/lib/php7 /var/www && \
    chown -R www-data:www-data /etc/php7 /var/log/php7 /usr/lib/php7 /var/www

# chown timezone files
RUN touch /etc/timezone /etc/localtime && \
    chown www-data:www-data /etc/localtime /etc/timezone

# set volume
VOLUME ["/etc/php7", "/var/log/php7", "/var/www"]

# copy run file
COPY scripts/run.sh /home/www-data/run.sh
RUN chmod +x /home/www-data/run.sh
COPY scripts/continue.sh /home/www-data/continue.sh
RUN chmod +x /home/www-data/continue.sh

ENTRYPOINT ["/home/www-data/run.sh", "su", "-m", "root", "-c", "/home/www-data/continue.sh /bin/sh"]