FROM liammartens/php
MAINTAINER Liam Martens (hi@liammartens.com)

# install phalcon
RUN apk add php$PHPV-dev make autoconf \
            gcc pcre-dev git g++ alpine-sdk
RUN ln -s /usr/bin/php7 /usr/bin/php
RUN git clone --single-branch git://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install
RUN apk del php$PHPV-dev make autoconf \
            gcc pcre-dev g++ alpine-sdk &&\
            rm -rf cphalcon

ENTRYPOINT ["/home/www-data/run.sh", "su", "-m", "www-data", "-c", "/home/www-data/continue.sh /bin/sh"]
