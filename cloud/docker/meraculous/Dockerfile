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
RUN curl -L https://sourceforge.net/projects/meraculous20/files/Meraculous-v2.2.5.tar.gz/download -o /tmp/meraculous.tgz
RUN mkdir /tmp/meraculous \
    && tar -xzf /tmp/meraculous.tgz -C /tmp/meraculous

RUN cd /tmp/meraculous/RELEASES/Meraculous-v2.2.5/ \
    && mkdir build /opt/meraculous \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/opt/meraculous .. \
    && make \
    && make install

# TODO: see why multi stage builds aren't working - ideally we would have a second, smaller image with just the build artifacts
#FROM ubuntu:16:04
#RUN apt-get update && apt-get -y install \
#    libboost-all-dev \
#    liblog-log4perl-perl \
#    gnuplot
#
#COPY --from=0 /opt/meraculous /opt/meraculous
