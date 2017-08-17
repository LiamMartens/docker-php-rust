FROM liammartens/php
MAINTAINER Liam Martens (hi@liammartens.com)

# install phalcon
RUN apk add --update rust cargo

ENTRYPOINT ["/home/www-data/run.sh", "su", "-m", "www-data", "-c", "/home/www-data/continue.sh /bin/sh"]
