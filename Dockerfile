FROM ubuntu:16.04
MAINTAINER Marc Laliberte
ENV DEBIAN_FRONTEND noninteractive
USER root

# Add mongo key to sources
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
  echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Main packages
RUN apt-get update && \
  apt install -y --no-install-recommends \
    mongodb-org \
    python \
    libev-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    curl \
    ca-certificates \
    git

RUN update-ca-certificates

# Setup Mongo
RUN mkdir -p /data/db

# Install PIP
WORKDIR /tmp
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py >> get-pip.py && \
  python get-pip.py && \
  pip install --upgrade setuptools

# PIP installs
RUN pip install -q cffi \
      pyopenssl==0.14 \
      pymongo \
      greenlet \
      gevent
RUN pip install -e git+https://github.com/rep/evnet.git#egg=evnet-dev

# hpfeeds
WORKDIR /opt
RUN git clone https://github.com/marclaliberte/hpfeeds.git && \
  cd hpfeeds && \
  pip install .

# User Setup
RUN groupadd -r artemis && \
  useradd -r -g artemis -d /home/artemis -s /sbin/nologin -c "Artemis User" artemis && \
  chown -R artemis:artemis /opt/hpfeeds

USER artemis
ENV HOME /home/artemis
ENV USER artemis
WORKDIR /opt/hpfeeds/broker
