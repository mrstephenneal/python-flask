# Start from Python 3.7 Alpine image
FROM python:3.7-slim
LABEL maintainer="Stephen Neal <stephen@stephenneal.net>"

# Updating operating system and install nginx
RUN apt-get update && apt-get install -y nginx

# inspired by: https://bradleyzhou.com/posts/building-slim-uwsgi-docker-image
# uwsgi, adapted from https://github.com/docker-library/python.git
# in file python/3.6/slim/Dockerfile
RUN set -ex \
    && buildDeps=' \
        gcc \
        libbz2-dev \
        libc6-dev \
        libgdbm-dev \
        liblzma-dev \
        libncurses-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libpcre3-dev \
        make \
        tcl-dev \
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev \
    ' \
    && deps=' \
        libexpat1 \
    ' \
    && apt-get update && apt-get install -y $buildDeps $deps --no-install-recommends  && rm -rf /var/lib/apt/lists/* \
    && pip install uwsgi \
    && apt-get purge -y --auto-remove $buildDeps \
    && find /usr/local -depth \
    \( \
        \( -type d -a -name test -o -name tests \) \
        -o \
        \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    \) -exec rm -rf '{}' +

# Update pip
RUN pip3 install --upgrade pip

# Install flask & uwsgi dependencies
RUN pip3 install uwsgi flask flask-RESTful