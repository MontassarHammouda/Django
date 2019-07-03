FROM ubuntu:16.04


# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive
ENV DOCKER_DEV true

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

RUN useradd -m docker

RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY docker-entrypoint.sh /

RUN chmod 777 /docker-entrypoint.sh

#USER docker

RUN mkdir -p /home/docker/app/

WORKDIR /home/docker/app

ENTRYPOINT ["/docker-entrypoint.sh"]
