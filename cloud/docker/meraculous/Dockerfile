# Can't use latest ubuntu because meraculous requires older gcc
FROM ubuntu:16.04

RUN apt-get update && apt-get -y install \
    build-essential \
    curl \
    cmake \
    gnuplot \
    libboost-all-dev \
    liblog-log4perl-perl

# don't use ADD because it re-downloads every time
RUN mkdir /tmp/meraculous \
    && cd /tmp/meraculous \
    && curl -L https://sourceforge.net/projects/meraculous20/files/Meraculous-v2.2.5.tar.gz/download | tar xzf - \
    && cd /tmp/meraculous/RELEASES/Meraculous-v2.2.5/ \
    && mkdir build /opt/meraculous \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/opt/meraculous .. \
    && make \
    && make install \
    && rm -rf /tmp/meraculous

ENV PATH "$PATH:/opt/meraculous/bin"
