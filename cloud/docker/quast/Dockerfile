FROM ubuntu:18.04

LABEL maintainer="John Kern <kern3020@gmail.com>"

# prevent tzdata from asking about where we are
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y \
    # needed for E-MEM build system
    csh \
    curl \
    # also for E-MEM
    libboost-all-dev \
    libfreetype6-dev \
    libpng-dev \
    pkg-config \
    python-matplotlib \
    python-setuptools \
    python \
    # simplejson
    python-dev

# quast claims to be python3 compatible, but it's not, so we use ancient python.

RUN mkdir /tmp/quast \
    && cd /tmp/quast \
    && curl -L https://downloads.sourceforge.net/project/quast/quast-4.6.3.tar.gz | tar xzf - \
    && cd /tmp/quast/quast-4.6.3 \
    && ./setup.py install \
    && ./setup.py test \
    && rm -rf /tmp/quast

ENTRYPOINT ["/usr/local/bin/quast.py"]
