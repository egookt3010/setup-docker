FROM ubuntu:18.04

LABEL author="Radityo P W (radityo.p.w@gmail.com)"

ARG DEBIAN_FRONTEND=noninteractive

# UPDATE PACKAGES
RUN apt-get update

# INSTALL SYSTEM UTILITIES
RUN apt-get install -y \
    apt-utils \
    curl \
    git \
    apt-transport-https \
    software-properties-common \
    g++ \
    build-essential \
    dialog

# INSTALL APACHE2
RUN apt-get install -y apache2
RUN a2enmod rewrite

# INSTALL locales
RUN apt-get install -qy language-pack-en-base \
    && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# INSTALL PHP & LIBRARIES
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get --no-install-recommends --no-install-suggests --yes --quiet install \
    php-pear \
    php7.4 \
    php7.4-common \
    php7.4-mbstring \
    php7.4-dev \
    php7.4-xml \
    php7.4-cli \
    php7.4-mysql \
    php7.4-sqlite3 \
    php7.4-mbstring \
    php7.4-curl \
    php7.4-gd \
    php7.4-imagick \
    php7.4-xdebug \
    php7.4-xml \
    php7.4-zip \
    php7.4-odbc \
    php7.4-opcache \
    php7.4-redis \
    autoconf \
    zlib1g-dev \
    libapache2-mod-php7.4

# INSTALL ODBC DRIVER & TOOLS


RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y \
    msodbcsql18 \
    mssql-tools18 \
    unixodbc \
    unixodbc-dev

RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
RUN exec bash

# INSTALL & LOAD SQLSRV DRIVER & PDO
RUN pecl install sqlsrv
RUN echo "extension=sqlsrv.so" > /etc/php/7.4/cli/conf.d/20-sqlsrv.ini
RUN echo "extension=sqlsrv.so" > /etc/php/7.4/apache2/conf.d/20-sqlsrv.ini

RUN pecl install pdo_sqlsrv
RUN echo "extension=pdo_sqlsrv.so" > /etc/php/7.4/cli/conf.d/30-pdo_sqlsrv.ini
RUN echo "extension=pdo_sqlsrv.so" > /etc/php/7.4/apache2/conf.d/30-pdo_sqlsrv.ini


# install gRPC 
RUN pecl install gRPC
RUN echo "extension=grpc.so" > /etc/php/7.4/cli/conf.d/40-grpc.ini
RUN echo "extension=grpc.so" > /etc/php/7.4/apache2/conf.d/40-grpc.ini

# install protobuf
RUN pecl install protobuf
RUN echo "extension=protobuf.so" > /etc/php/7.4/cli/conf.d/50-protobuf.ini
RUN echo "extension=protobuf.so" > /etc/php/7.4/apache2/conf.d/50-protobuf.ini


EXPOSE 80


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]