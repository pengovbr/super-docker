################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

FROM alpine:3.12

RUN apk add --no-cache \
      apache2 \ 
      apache2-http2 \
      php7-apache2 \
      php7-bcmath \
      php7-calendar \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-gd \
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
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

# wkhtmltopdf #
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-866998106 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf
      
COPY assets/sei.ini /etc/php7/conf.d/
COPY assets/sei.conf /etc/apache2/conf.d/ 

RUN apk add openjdk8

EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]
