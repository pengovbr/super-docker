################################################################################
# Dockerfile de construcao do container APP com os pacotes basicos
################################################################################

FROM alpine:3.13

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

# Utiliza versão 1.1.4 pois há uma segmentation fault no 1.1.3
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/v3.14/community/ \
    php7-pecl-uploadprogress;

# Pacotes para o wkhtmltopdf
RUN apk add --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation 

# wkhtmltopdf #
COPY --from=madnight/docker-alpine-wkhtmltopdf:0.12.5-alpine3.13 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf

RUN apk add --no-cache openjdk8

COPY assets/sei.ini /etc/php7/conf.d/99_sei.ini
COPY assets/xdebug.ini /etc/php7/conf.d/99_xdebug.ini
COPY assets/sei.conf /etc/apache2/conf.d/ 

# Pasta para arquivos externos
RUN mkdir -p /var/sei/arquivos && chown apache.apache /var/sei/arquivos

# Suporte para atualização do SEI. O script de atualização do SEI está fixo no bash
RUN apk add --no-cache \
    bash;

EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]
