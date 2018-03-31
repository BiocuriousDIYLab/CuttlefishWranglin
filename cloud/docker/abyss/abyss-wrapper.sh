#!/bin/bash

DATA_DIR=/home/kern3020/data/tinker

# abyss assembler: https://github.com/bcgsc/abyss
# to run the test:
# download test data
# 1) wget http://www.bcgsc.ca/platform/bioinfo/software/abyss/releases/1.3.4/test-data.tar.gz
# uncompress into DATA-DIR
# 2) tar xzvf test-data.tar.gz
# use this script to start image and run...
# 3) abyss-pe k=25 name=test in='/data/test-data/reads1.fastq /data/test-data/reads2.fastq'

docker run --rm -it -v ${DATA_DIR}:/data kern3020/abyss:2017-328 /bin/bash

