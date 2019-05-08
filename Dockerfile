# Start from Python 3.7 image
FROM python:3.7
LABEL maintainer="Stephen Neal <stephen@stephenneal.net>"

# Updating operating system and install nginx
RUN apt-get update && apt-get install -y nginx

# Update pip
RUN pip3 install --upgrade pip

# Install flask & uwsgi dependencies
RUN pip3 install uwsgi flask flask-RESTful