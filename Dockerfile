FROM alpine:latest AS iwp

ARG IWP_VERSION=2.15.1
ARG INSTALL=false

RUN \
  apk update && \
  apk add --upgrade unzip

WORKDIR /tmp

COPY IWPAdminPanel_v$IWP_VERSION.zip /tmp

RUN \
  unzip IWPAdminPanel_v$IWP_VERSION.zip && \
  mv IWPAdminPanel_v$IWP_VERSION iwp && \
  if [ ! "$INSTALL" = true ]; then rm -rf iwp/install; fi

FROM php:7.0-apache

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libjpeg-dev \
    libmcrypt-dev && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-install mysqli

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
    echo 'file_uploads = On'; \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 32M'; \
    echo 'post_max_size = 32M'; \
    echo 'max_execution_time = 600'; \
    echo 'max_input_vars = 3000'; \
} > /usr/local/etc/php/conf.d/infinitewp.ini

RUN a2enmod rewrite expires

COPY htaccess .htaccess

COPY --from=iwp /tmp/iwp /var/www/html/iwp

RUN \
  chmod 755 .htaccess && \
  chown www-data:www-data .htaccess && \
  chown -R www-data:www-data /var/www/html/iwp
