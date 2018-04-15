FROM ubuntu:18.04

RUN apt-get update && apt-get install -y software-properties-common

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'

RUN apt-get update && apt-get -y install \
    curl \
    unzip \
    libfindbin-libs-perl \
    zulu-9

RUN cd /opt \
    && curl http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.7.zip -o fastqc.zip \
    && unzip fastqc.zip \
    && rm fastqc.zip \
    && chmod a+x /opt/FastQC/fastqc

ENTRYPOINT ["/opt/FastQC/fastqc"]
