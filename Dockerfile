FROM phpdockerio/php7-fpm:latest

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential php7.0-dev php7.0-mysql php7.0-sqlite3 php7.0-bcmath php7.0-bz2 php7.0-dba php7.0-gd php7.0-mbstring php7.0-soap php7.0-xmlrpc php7.0-xsl \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && mkdir -p /usr/local/ioncube

ADD ioncube_loader_lin_x86-64_7.0b8.so /usr/local/ioncube/ioncube_loader_lin_x86-64_7.0b8.so
ADD php-ini-overrides.ini /etc/php/7.0/fpm/conf.d/00-php-ini-overrides.ini
ADD php-ini-overrides.ini /etc/php/7.0/cli/conf.d/00-php-ini-overrides.ini

ADD xdebug-2.4.1 /tmp/xdebug-2.4.1/
RUN cd /tmp/xdebug-2.4.1 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/lib/php/20151012

RUN touch /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.remote_enable=1 >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.remote_autostart=0 >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.remote_connephpct_back=1 >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.remote_port=9000 >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.remote_log=/tmp/php-xdebug.log >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.show_local_vars=1 >> /etc/php/7.0/fpm/conf.d/xdebug.ini; \
    echo xdebug.idekey=PHPSTORM >> /etc/php/7.0/fpm/conf.d/xdebug.ini;

WORKDIR "/var/www/html"
