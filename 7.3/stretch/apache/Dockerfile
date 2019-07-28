FROM akhfa/php-ioncube:7.3-apache-stretch
ENV PHP_VERSION 7.3
ENV BLESTA_VERSION 4.6.0

# Blesta
RUN apt update \
    && apt install -y \
    libgmp-dev \
    libpng-dev \
    libc-client-dev \
    libkrb5-dev \
    libldap2-dev \
    libxml2-dev \
    unzip \
    wget \
    && apt clean
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install gd \
    gmp \
    imap \
    # ioncube-loader \
    json \
    ldap \
    mbstring \
    pdo \
    pdo_mysql \
    # pecl-mailparse \
    simplexml

RUN cd /tmp \
    && wget https://account.blesta.com/client/plugin/download_manager/client_main/download/133/blesta-${BLESTA_VERSION}.zip \
    && unzip -q blesta-${BLESTA_VERSION}.zip \
    && mv blesta/* /var/www/html/ \
    && mv blesta/.htaccess /var/www/html/ \
    && mv uploads /var/www/ \
    && rm -rf blesta* hotfix* LICENSE README.md \
    && chown -R www-data:www-data /var/www/html /var/www/uploads
