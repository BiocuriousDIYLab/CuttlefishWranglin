# Pichia Pastoris Pipeline

Here we document a pipeline for [Pichia pastoris also known as Komagataella
phaffii](https://en.wikipedia.org/wiki/Pichia_pastoris).  It is a
well-known species of yeast used in biotech for protein
production.

## Tool setup

- `sra-tools`: Docker image `biocurious/sra-tools:2.9.0`.
- `fastqc`: Build an image via `/cloud/docker`.
- `spades`: Docker image `biocurious/spades:3.11.1`.
- `busco`: Build an image via `/cloud/docker`.

For the tools we have Docker images for, you can also install them in your host OS if you prefer, but they might be 
annoying to build depending on yuor compiler version, etc. If you want to go this path, 
[Bioconda](https://bioconda.github.io/) may help.

## Data

We'll be doing work in `$BIO_DATA/pichia` where `$BIO_DATA` is a placeholder for wherever you choose to store your large 
files for this project. If you don't have somewhere in mind, just `mkdir -p data/pichia` in the root of this repository. 

We'll be mounting the `$BIO_DATA` dir as `/data` inside Docker containers to run various tools. You can simply update
the commands to point to whatever directory you're using, or set a shell variable with `BIO_DATA=/foo/bar/baz` so that 
the proper value is interpolated in when you execute the commands.

Either way, Docker insists that the host OS path for a volume be an absolute path (i.e. `/foo/bar/baz`, not `./baz` or `baz`).

## Retrieving the sample
Here we are using this [data
set](https://www.ncbi.nlm.nih.gov/sra/ERX1365588[accn]) from NCBIs
Sequence Read Archive(SRA). The [sratools](https://github.com/ncbi/sra-tools) are used to download samples. 

Download the data as follows (uses about 7GiB of disk). You can specify the output location with `--output` for 
`fastq-dump`. Here, we want to save `fastq-dump`'s output into a Docker volume mounted into the container so we can 
access the files outside of that container. See the README in `/cloud/docker` for more.

```
docker run -i --rm -t -v $BIO_DATA:/data biocurious/sra-tools:2.9.0 \
    fastq-dump \
    --outdir /data/pichia \
    --gzip \
    --split-files \
    ERR1294016
```

If you've installed `sratools` into your host OS, you could also use `vdb-config` to move sratools' cache from the 
default location, your home directory, to a partition were there is ample space. Then, you shouldn't need to specify
`--output` each time.

```
~/src/sratoolkit.2.8.2-1-ubuntu64/bin/vdb-config -i
```

## Quality Check
[fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is a well-known program to evaluate the quality of 
the quality of raw NGS sequencing data.

```
docker run -i --rm -t -v $BIO_DATA:/data <fastqc image id>\
    /data/pichia/ERR1294016_1.fastq.gz \
    /data/pichia/ERR1294016_2.fastq.gz \
    -o /data/pichia/fastqc
```

For our pichia postoria sample, fastqc shows the sequence length is 50 and there is some duplication. I do not see any bases I want to trim. 

## Assembly

We select the [SPAdes](http://cab.spbu.ru/software/spades/), St. Petersburg genome assembler.

```
docker run -i --rm -v $BIO_DATA:/data -t biocurious/spades:3.11.1 spades.py \
    -o /data/pichia/assembly \
    -1 /data/pichia/ERR1294016_1.fastq.gz \
    -2 /data/pichia/ERR1294016_2.fastq.gz
```

The first time, the assemble process took about 10 hours on a single node with 8GBs of RAM. There is room for improving 
the performance. Another run with 16GB RAM and 2 6-core cpus finished in under 2 hours.

## Assessing assembly results

How does one assess the quality of the assembly results? [BUSCO](http://busco.ezlab.org/), 

>BUSCO v3 provides quantitative measures for the assessment of genome assembly, gene set, and transcriptome completeness, based on evolutionarily-informed expectations of gene content from near-universal single-copy orthologs selected from OrthoDB v9.

To apply it to our sample we need to download... 

```
cd $BIO_DATA/pichia && curl http://busco.ezlab.org/datasets/saccharomycetales_odb9.tar.gz | tar xzf -
```

Then we can run BUSCO. 

```
docker run -i --rm -v $BIO_DATA:/data -t <busco image id> run_BUSCO.py \
    -m genome \
    --in /data/pichia/assembly/scaffolds.fasta \
    --out busco-pichia \
    --lineage_path /data/pichia/saccharomycetales_odb9 \
    --cpu 4
```

Since BUSCO is configured to use `/data` as its output path and we passed `--out busco-pichia`, this will output into 
`/data/run_bosco-pichia`. (Yes, this is bizarrely complicated... that's just how BUSCO is.)

## Gene prediction


