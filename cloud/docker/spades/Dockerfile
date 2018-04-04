FROM ubuntu:18.04

RUN apt-get update && apt-get -y install \
    build-essential \
    cmake \
    curl \
    libbz2-dev \
    python3 \
    zlib1g-dev

RUN mkdir /tmp/spades
RUN curl http://cab.spbu.ru/files/release3.11.1/SPAdes-3.11.1.tar.gz -o /tmp/spades/spades.tgz

RUN cd /tmp/spades \
    && tar xzf spades.tgz \
    && cd SPAdes-3.11.1 \
    && PREFIX=/opt/spades ./spades_compile.sh

# scripts use `python`, not a specific version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
