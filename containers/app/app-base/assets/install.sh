


#!/bin/bash

set -e

yum clean all
yum -y update
yum -y install epel-release

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

openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/localhost.key -x509 -days 365 -out /etc/pki/tls/certs/localhost.crt \
  -subj "/C=BR/ST=Brasilia/L=Brasilia/O=TESTE/OU=MGI/CN=localhost"


# Instalação do PHP e demais extenções necessárias para o projeto
yum install -y yum-utils dnf-plugins-core
yum install -y http://rpms.remirepo.net/enterprise/remi-release-8.rpm
yum module reset php -y
yum module enable php:remi-7.3 -y
dnf config-manager --set-enabled powertools
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
    php-pecl-gearman \
    cronie \
    php-sodium \
    git

cd /tmp/assets/pacotes

# Configuração do pacote de línguas pt_BR
dnf install glibc-locale-source glibc-langpack-br -y
localedef -c -i pt_BR -f ISO-8859-1 pt_BR.ISO-8859-1

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
rpm -Uvh wkhtmltox-0.12.6-1.centos8.x86_64.rpm

# fonts libraries
rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm

if [ "$IMAGEM_APP_PACOTEMYSQL_PRESENTE" == "true" ]; then

  yum install -y mysql php-mysqli

fi

if [ "$IMAGEM_APP_PACOTESQLSERVER_PRESENTE" == "true" ]; then

    # Instalação dos componentes de conexão do SQL Server
    curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo
    ACCEPT_EULA=Y yum install -y msodbcsql17
    yum install -y libtool-ltdl-devel unixODBC unixODBC-devel php-pdo
    pecl channel-update pecl.php.net
    pecl install sqlsrv-5.10.1 pdo_sqlsrv-5.10.1
    printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php.d/20-sqlsrv.ini
    printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php.d/30-pdo_sqlsrv.ini

    # Ver issue #19
    mkdir /opt2
    mv /opt/microsoft /opt2
    ln -s /opt2/microsoft /opt/microsoft

fi

if [ "$IMAGEM_APP_PACOTEORACLE_PRESENTE" == "true" ]; then

    # ORACLE oci
    yum install -y libnsl
    yum install -y \
        oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
        oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm \
        oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

    echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf
    ldconfig

    # Install Oracle extensions
    yum install -y gcc gcc-c++ make php-devel php-pear systemtap-sdt-devel
    pecl channel-update pecl.php.net
    export PHP_DTRACE=yes && pecl install oci8-2.2.0 && unset PHP_DTRACE

    echo "extension=oci8.so" > /etc/php.d/oci8.ini

fi

cd -
