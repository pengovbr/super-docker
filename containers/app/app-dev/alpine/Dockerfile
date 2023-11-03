################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

FROM php:7.3-zts-alpine3.14

RUN apk add --no-cache \
      apache2 \ 
      apache2-http2 \
      php7-apache2 \
      php7-bcmath \
      php7-calendar \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-fileinfo \
      php7-gd \
      php7-gettext \
      php7-gmp \
      php7-imap \
      php7-intl \
      php7-ldap \
      php7-mbstring \
      php7-mcrypt \
      php7-mysqli \
      php7-odbc \
      php7-pcntl \
      php7-pdo \
      php7-pear \
      php7-pecl-apcu \
      php7-pecl-mcrypt \
      php7-pecl-memcache \
      php7-pecl-memcached \
      php7-pecl-uploadprogress \
      php7-pecl-xdebug \
      php7-pspell \
      php7-shmop \
      php7-snmp \
      php7-soap \
      php7-xml \
      php7-xmlrpc \
      php7-zip \
      php7-zlib \
      ;

# Pacotes para o wkhtmltopdf
RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation 

# wkhtmltopdf #
COPY --from=madnight/docker-alpine-wkhtmltopdf:0.12.5-alpine3.13 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf

RUN apk add --no-cache openjdk8

COPY assets/sei.ini /etc/php7/conf.d/
COPY assets/xdebug.ini /etc/php7/conf.d/99_xdebug.ini
COPY assets/sei.conf /etc/apache2/conf.d/ 

# Pasta para arquivos externos
RUN mkdir -p /var/sei/arquivos && chown apache.apache /var/sei/arquivos

EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]
