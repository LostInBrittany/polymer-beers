# Docker demo image, as used on try.jupyter.org and tmpnb.org

FROM python:alpine

MAINTAINER Michael Bright  <dockerfile@mjbright.net>

## # Perform initial update/upgrade to get latest packages/security updates:
## RUN apt-get update && ## \
##     apt-get upgrade -y

# Install git
RUN apk add --update git

# Clone repo
RUN mkdir -p /root/src/git && \
    git clone https://github.com/mjbright/polymer-beers /root/src/git/polymer-beers

WORKDIR /root/src/git/polymer-beers

CMD python -m http.server

