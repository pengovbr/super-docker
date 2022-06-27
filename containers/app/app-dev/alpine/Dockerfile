################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

FROM alpine:3.12

RUN apk add --no-cache \
      apache2 \ 
      apache2-http2 \
      php7-apache2 \
      php7-pear \
      php7-mysqli \
      php7-bcmath \
    php7-bcmath \
    php7-gd \
    php7-gmp \
    php7-imap \
    php7-intl \
    php7-ldap \
    php7-mbstring \
    php7-odbc \
    php7-pdo \
    php7-pecl-apcu \
    php7-pspell \
    php7-zlib \
    php7-snmp \
    php7-soap \
    php7-xml \
    php7-xmlrpc \
    php7-pecl-memcache \
    php7-calendar \
    php7-shmop \
    php7-intl \
    php7-mcrypt \
    php7-zip \
    php7-pecl-uploadprogress \
      ; 
RUN apk add --no-cache php7-gearman gearman-libs \
      --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing 
      
COPY assets/sei.ini /etc/php7/conf.d/
COPY assets/sei.conf /etc/apache2/conf.d/ 

EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]