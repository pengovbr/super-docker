


#!/bin/bash

set -e

yum clean all
yum -y update

# Instalação dos componentes básicos do servidor web apache
yum -y install \
    httpd \
    memcached \
    openssl \
    wget \
    curl \
    zip \
    unzip \
    gcc \
    java-1.8.0-openjdk \
    libxml2 \
    cabextract \
    xorg-x11-font-utils \
    xorg-x11-fonts-75dpi \
    fontconfig \
    mod_ssl

# Instalação do PHP e demais extenções necessárias para o projeto
yum install -y epel-release yum-utils
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php73
yum -y update

# Instalação do PHP e demais extenções necessárias para o projeto
yum -y install \
    php php-common \
    php-cli \
    php-pear \
    php-bcmath \
    php-gd \
    php-gmp \
    php-imap \
    php-intl \
    php-ldap \
    php-mbstring \
    php-odbc \
    php-pdo \
    php-pecl-apcu \
    php-pspell \
    php-zlib \
    php-snmp \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-zts \
    php-devel \
    php-pecl-apcu-devel \
    php-pecl-memcache \
    php-calendar \
    php-shmop \
    php-intl \
    php-mcrypt \
    php-zip \
    php-pecl-zip \
    gearmand \
    libgearman \
    libgearman-devel \
    php-pecl-gearman \
    vixie-cron \
    php-sodium \
    git \
    gearmand \
    libgearman-dev \
    libgearman-devel


cd /tmp/assets/pacotes

# Instalação do componentes UploadProgress
tar -zxvf uploadprogress.tgz
cd uploadprogress
phpize
./configure --enable-uploadprogress
make
make install
echo "extension=uploadprogress.so" > /etc/php.d/uploadprogress.ini
cd -

# wkhtml
rpm -Uvh wkhtmltox-0.12.6-1.centos7.x86_64.rpm

# fonts libraries
rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm

if [ "$IMAGEM_APP_PACOTEMYSQL_PRESENTE" == "true" ]; then

  yum install -y mysql php-mysqli

fi

if [ "$IMAGEM_APP_PACOTESQLSERVER_PRESENTE" == "true" ]; then

    yum install -y freetds freetds-devel php-mssql

fi

if [ "$IMAGEM_APP_PACOTEORACLE_PRESENTE" == "true" ]; then

    # ORACLE oci

    yum install -y \
        oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
        oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm \
        oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

    echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf
    ldconfig

    # Install Oracle extensions
    yum install -y php-dev php-pear build-essential systemtap-sdt-devel
    pecl channel-update pecl.php.net
    export PHP_DTRACE=yes && pecl install oci8-2.2.0 && unset PHP_DTRACE

    echo "extension=oci8.so" > /etc/php.d/oci8.ini

fi

cd -
