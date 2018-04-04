FROM ubuntu:18.04

RUN apt-get update && apt-get -y install \
    bamtools \
    build-essential \
    cmake \
    curl \
    git \
    hmmer \
    libbamtools-dev \
    libboost-iostreams-dev \
    ncbi-blast+ \
    python3 \
    zlib1g-dev

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

WORKDIR /opt

RUN curl http://bioinf.uni-greifswald.de/augustus/binaries/augustus-3.3.tar.gz | tar xzf -

RUN git clone https://gitlab.com/ezlab/busco.git

RUN cd busco && python3 setup.py install --user

RUN cd augustus && make

# Use a custom file, but don't overwrite the default one in case people want to compare.
COPY busco/busco-config.ini /opt/busco/config/docker-config.ini
ENV BUSCO_CONFIG_FILE=/opt/busco/config/docker-config.ini

ENV AUGUSTUS_CONFIG_PATH=/opt/augustus/config
ENV PATH "$PATH:/opt/augustus/bin"

