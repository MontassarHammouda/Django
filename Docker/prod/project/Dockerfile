FROM ubuntu:16.04



# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive
ENV DOCKER_DEV false

# install Dependecies
RUN \
apt-get update -qq && \
apt-get install -y \
build-essential \
apt-utils &&\
apt-get install -y \
aptdaemon \
ed git \
libcairo-dev \
libedit-dev \
libzmq-dev \
libapparmor1 \
libpq-dev \
libedit2 \
libssl1.0.0 \
libcurl4-gnutls-dev \
#libcurl4-openssl-dev \
libssl-dev \
python3.7 python-pip python-dev \
python3.7 python3-pip python3.7-venv \
unzip zip \
sudo \
screen \
wget &&\
apt-get install -y \
libapache2-mod-wsgi apache2 apache2-utils &&\
rm -rf /var/lib/apt/lists/*

# install Python libraries
RUN \
pip --no-cache-dir install virtualenv --upgrade && \
easy_install distribute && \
rm -rf /root/.cache

RUN apt-get update && \
    apt-get install binutils libproj-dev gdal-bin libgeoip1 postgis python-gdal -y &&\
    rm -rf /var/lib/apt/lists/*

ENV SHELL /bin/bash

RUN useradd -m docker &&\
  echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY docker-entrypoint.sh /

RUN chmod 777 /docker-entrypoint.sh &&\
  mkdir -p /var/www &&\
  chown -R docker:docker /var/www

ENV APACHE_RUN_USER docker
ENV APACHE_RUN_GROUP docker
ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid
#ENV APACHE_RUN_DIR /var/run/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2

RUN /usr/sbin/a2ensite default-ssl &&\
  /usr/sbin/a2enmod ssl &&\
  echo "WSGIPassAuthorization On" >> /etc/apache2/apache2.conf &&\
  echo "WSGIApplicationGroup %{GLOBAL}" >> /etc/apache2/apache2.conf &&\
  echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
  service apache2 restart &&\
  service apache2 stop

EXPOSE 80
EXPOSE 443

#USER docker

RUN mkdir -p /home/docker/app/

WORKDIR /home/docker/app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["apache2ctl", "-D", "FOREGROUND"]
