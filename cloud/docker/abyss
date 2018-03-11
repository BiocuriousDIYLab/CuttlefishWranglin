FROM ubuntu:16.04

MAINTAINER John Kern <kern3020@gmail.com>

ENV PATH="/usr/local/sratoolkit.2.8.2-1-ubuntu64/bin:${PATH}"


RUN apt-get update && apt-get install -y wget abyss bsdmainutils

RUN cd /tmp/ && wget --quiet https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2-1/sratoolkit.2.8.2-1-ubuntu64.tar.gz && cd /usr/local/ && tar -xvf /tmp/sratoolkit.2.8.2-1-ubuntu64.tar.gz && rm /tmp/sratoolkit.2.8.2-1-ubuntu64.tar.gz

RUN useradd -ms /bin/bash seeker
USER seeker
WORKDIR /home/seeker
