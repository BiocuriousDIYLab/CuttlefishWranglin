FROM ubuntu:16.04

MAINTAINER John Kern <kern3020@gmail.com>

RUN apt-get update && apt-get install -y pkg-config libfreetype6-dev libpng-dev python-matplotlib

ADD https://downloads.sourceforge.net/project/quast/quast-4.6.1.tar.gz /tmp

RUN cd /usr/local && tar zxvf /tmp/quast-4.6.1.tar.gz



RUN useradd -ms /bin/bash seeker
USER seeker
WORKDIR /home/seeker
