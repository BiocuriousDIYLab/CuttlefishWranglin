FROM ubuntu:18.04

RUN apt-get update && apt-get -y install \
    build-essential \
    cmake \
    curl \
    libbz2-dev \
    python3 \
    zlib1g-dev

RUN mkdir /tmp/spades \
    && cd /tmp/spades \
    && curl http://cab.spbu.ru/files/release3.11.1/SPAdes-3.11.1.tar.gz | tar xzf - \
    && cd SPAdes-3.11.1 \
    && PREFIX=/opt/spades ./spades_compile.sh \
    && rm -rf /tmp/spades

# scripts use `python`, not a specific version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

ENV PATH "$PATH:/opt/spades/bin"
