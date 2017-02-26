# Custom PHP docker image
* PHP 7 with Redis support
* Sets the timezone to UTC or to the value in the TIMEZONE environment variable
* Runs as www-data user (after taking file ownership)
* Defines 3 volumes (/etc/php7 for the configuration, /var/log/php7 for the log files and /var/www for the content)
* Binds to port 9000 by default but can be overridden by a PHP_PORT environment variable
* Automatically updates the conf/php-fpm.d/www.conf file with the correct IP and port.