FROM phpdockerio/php71-fpm:latest

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential php7.1-dev php7.1-mysql php7.1-sqlite3 php7.1-bcmath php7.1-bz2 php7.1-dba php7.1-gd php7.1-mbstring php7.1-soap php7.1-xmlrpc php7.1-xsl \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && mkdir -p /usr/local/ioncube

ADD ioncube_loader_lin_7.1.so /usr/local/ioncube/ioncube_loader_lin_7.1.so
ADD 00-ioncube.ini /etc/php/7.1/fpm/conf.d/00-ioncube.ini
ADD 00-ioncube.ini /etc/php/7.1/cli/conf.d/00-ioncube.ini
ADD php-ini-overrides.ini /etc/php/7.1/fpm/conf.d/80-php-ini-overrides.ini
ADD php-ini-overrides.ini /etc/php/7.1/cli/conf.d/80-php-ini-overrides.ini

ADD xdebug-2.5.5 /tmp/xdebug-2.5.5/
RUN cd /tmp/xdebug-2.5.5 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/lib/php/20160303

WORKDIR "/var/www/html"
