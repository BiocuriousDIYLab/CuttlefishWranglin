FROM ubuntu:18.04

RUN apt-get update && apt-get install -y software-properties-common

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'

RUN apt-get update && apt-get -y install \
    build-essential \
    git \
    python3-distutils \
    zulu-9

# ngs build uses `python`, not a specific version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN mkdir /tmp/ncbi \
    && cd /tmp/ncbi \
    && git clone https://github.com/ncbi/sra-tools.git \
    && git clone https://github.com/ncbi/ngs.git \
    && git clone https://github.com/ncbi/ncbi-vdb.git \
    && cd /tmp/ncbi/ngs \
    && git checkout 2.9.0 \
    && ./configure \
    && make \
    && make install \
    && cd /tmp/ncbi/ncbi-vdb \
    && git checkout 2.9.0 \
    && ./configure \
    && make \
    && make install \
    && cd /tmp/ncbi/sra-tools \
    && git checkout 2.9.0 \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/ncbi

ENV PATH="$PATH:/usr/local/ncbi/sra-tools/bin"
