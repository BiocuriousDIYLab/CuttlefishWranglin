# Pichia Pastoris Pipeline

Here we document a pipeline for [Pichia pastoris also known as Komagataella
phaffii](https://en.wikipedia.org/wiki/Pichia_pastoris).  It is a
well-known species of yeast used in biotech for protein
production.

## Retrieving the sample
Here we are using this [data
set](https://www.ncbi.nlm.nih.gov/sra/ERX1365588[accn]) from NCBIs
Sequence Read Archive(SRA). The [sratools](https://github.com/ncbi/sra-tools) are used to download samples. 

The author found it useful to move move sratools' cache from the default
location, your home directory, to /data/, a partition were there ws
ample space/.

```
$ ~/src/sratoolkit.2.8.2-1-ubuntu64/bin/vdb-config -i
```

Then you can download it as follows. [requies about 7GB of diskspace]
```
$ ~/src/sratoolkit.2.8.2-1-ubuntu64/bin/fastq-dump --gzip --split-files ERR1294016
```

## Quality Check
[fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is a well-known program to evaluate the quality of the quality of raw NGS sequencing data. One can run it as ... 

```
$ fastqc ERR1294016_1.fastq.gz ERR1294016_2.fastq.gz -o /data/project/picharia/fastqc
```
[aside: It can be difficult to install bioinformatics
tools. [Bioconda](https://bioconda.github.io/) can make it easy to install them]

For our pichia postoria sample, fastqc shows the sequence length is 50 and there is some duplication. I do not see any bases I want to trim. 

## Assembly

We select the [SPAdes](http://cab.spbu.ru/software/spades/), St. Petersburg genome assembler.
```
$ python /home/kern3020/miniconda3/bin/spades.py -o /data/project/picharia/assembly -1 /data/yeast/pichia/ERR1294016_1.fastq.gz -2 /data/yeast/pichia/ERR1294016_2.fastq.gz

real    596m2.078s
user    882m28.365s
sys     247m19.760s
```

The first time, the assemble process took about 10 hours on a single node with 8GBs of RAM. There is room for improving the performance. Another run with 16GB RAM and 2 6-core cpus, finished in under 2 hours.

## Assessing assembly results

How does one assess the quality of the assembly results? [BUSCO](http://busco.ezlab.org/), 

>BUSCO v3 provides quantitative measures for the assessment of genome assembly, gene set, and transcriptome completeness, based on evolutionarily-informed expectations of gene content from near-universal single-copy orthologs selected from OrthoDB v9.

To apply it to our sample we need to download... 

```
$ wget http://busco.ezlab.org/datasets/saccharomycetales_odb9.tar.gz
```

Then we can run BUSCO. 

```
$ export AUGUSTUS_CONFIG_PATH=/data/conda/miniconda3/pkgs/augustus-3.2.3-boost1.64_3/config

$ python /data/conda/miniconda3/bin/run_BUSCO.py -m genome -i /data/project/pichia/assembly/scaffolds.fasta   -l /data/yeast/saccharomycetales_odb9 -o pichia
```

## Gene prediction


