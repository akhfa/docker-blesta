FROM akhfa/php-ioncube:7.3-apache-stretch
ENV PHP_VERSION 7.3
ENV BLESTA_VERSION 4.6.0

# Blesta
RUN apt update \
    && apt install -y \
    cron \
    libgmp-dev \
    libpng-dev \
    libc-client-dev \
    libkrb5-dev \
    libldap2-dev \
    libxml2-dev \
    libmcrypt-dev \
    supervisor \
    unzip \
    wget \
    && apt clean
COPY blesta-cron /etc/cron.d/blesta-cron
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install \
      gd \
      gmp \
      imap \
      json \
      ldap \
      mbstring \
      pdo \
      pdo_mysql \
      simplexml \
    && pecl install \
      mcrypt-1.0.2 \
      mailparse \
    && docker-php-ext-enable \
      mcrypt \
      mailparse \
    && a2enmod rewrite

RUN cd /tmp \
    && wget -q https://account.blesta.com/client/plugin/download_manager/client_main/download/133/blesta-${BLESTA_VERSION}.zip \
    && unzip -q blesta-${BLESTA_VERSION}.zip \
    && mv blesta/* /var/www/html/ \
    && mv blesta/.htaccess /var/www/html/ \
    && mv uploads /var/www/ \
    && mkdir /var/www/logs_blesta \
    && rm -rf blesta* hotfix* LICENSE README.md \
    && chown -R www-data:www-data /var/www/html /var/www/uploads /var/www/logs_blesta

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY remoteip.conf /etc/apache2/conf-enabled/remoteip.conf

CMD ["/usr/bin/supervisord"]