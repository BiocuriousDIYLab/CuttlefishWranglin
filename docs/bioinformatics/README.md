## Databases

* [NCBI Sequencing Reads Archive - SRA](https://www.ncbi.nlm.nih.gov/sra)
* [OrthoMCL DB - identification of orthologous ORFs](http://orthomcl.org/orthomcl/) Ortholog Groups of Protein Sequences
* [SwissProt database](http://www.uniprot.org/)

### Genomic data

* Trade-off between transcriptome plasticity and genome evolution in cephalopods [denovo transcriptome](http://www.tau.ac.il/~elieis/squid/)
* From the original paper presented for this project. “Trade-off between Transcriptome Plasticity and Genome Evolution in Cephalopods” [SRX1396680: Genomic DNA sequencing of Sepia officinalis germline DNA](https://www.ncbi.nlm.nih.gov/sra/SRX1396680[accn])
* [Sepia officinalis \(common cuttlefish - MT only\)](https://www.ncbi.nlm.nih.gov/genome/7879)

## Tools

### Aligners

* [bwa](http://bio-bwa.sourceforge.net/) dominant aligner for Illumina
* [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) original paper and RNA-edit survey paper refer to it.
* [Spliced Transcripts Alignment to a Reference - STAR](https://github.com/alexdobin/STAR) RNA-seq aligner
* [tophat](http://ccb.jhu.edu/software/tophat/index.shtml) maps RNA-seq reads to the genome.

### RNA

* [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/) Transcriptome assembly and differential expression analysis for RNA-Seq.
* [RSEM](https://deweylab.github.io/RSEM/) RNA-Seq by Expectation-Maximization. Accurate quantification of gene and isoform expression from RNA-Seq data
* [HTseq count](http://htseq.readthedocs.io/en/release_0.9.1/) HTSeq: Analysing high-throughput sequencing data with Python
* [Kalisto](https://pachterlab.github.io/kallisto/about) kallisto is a program for quantifying abundances of transcripts from RNA-Seq data

### Functional analysis

* [Blast2GO](https://en.wikipedia.org/wiki/Blast2GO) - \(commercial\) A bioinformatics platform for high-quality protein function prediction and functional analysis of genomic datasets

### Assemblers

DNA

* [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss), [github](https://github.com/bcgsc/abyss)
* [Discovar](https://software.broadinstitute.org/software/discovar/blog/)
* [Meraculous](https://jgi.doe.gov/data-and-tools/meraculous/)
* [SOAP](http://soap.genomics.org.cn/soapdenovo.html), [github](https://github.com/aquaskyline/SOAPdenovo2)
* [MaSuRCA assembler](http://www.genome.umd.edu/masurca.html) used for the recent wheat genome

RNA

* [SOAPdenovo-Trans ](https://github.com/aquaskyline/SOAPdenovo-Trans)
* [Trinity RNA-seq \(last commit - March 2015\)](https://github.com/trinityrnaseq/trinityrnaseq/wiki)

Tools:
* [busco](http://busco.ezlab.org) _provides quantitative measures for the assessment of genome assembly, gene set, and transcriptome completeness, based on evolutionarily-informed expectations of gene content from near-universal single-copy orthologs selected from OrthoDB v9_. 
* [QUAST - Quality Assessment Tool for Genome Assemblies](http://quast.sourceforge.net/)
* [preseq](http://smithlabresearch.org/software/preseq/)_The preseq package is aimed at predicting and estimating the complexity of a genomic sequencing library, equivalent to predicting and estimating the number of redundant reads from a given sequencing depth and how many will be expected from additional sequencing using an initial sequencing experiment._


Project:

* [Assemblathon](http://assemblathon.org/) was a project to evaluate genome assemblers.
* [GAGE - Genome Assembly Gold-Standard Evaluations](http://gage.cbcb.umd.edu/) a similar project to Assemblathon.

### NCBI

The [National Center for Biotechnology Information\(NCBI\)](https://www.ncbi.nlm.nih.gov/) contains an amazing plethora of bioinformatics information.  Raw Next Generation Sequencing \(NGS\) data is found on the [Sequence Read Archive \(SRA\)](https://www.ncbi.nlm.nih.gov/sra) section.

The Sequence Read Archive basically includes intensity, read and alignment data. All this data requires a lot of space. We only want to extract the two fastq files representing the reads. NCBI provides a collection of command line tools called the [SRA toolkit](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software) to extract fastq files. We will use the fastq-dump command to retrieve the data we require.

As an example, I selected [ERX276244: Whole Genome Sequencing of fungal endophyte sp. D3-2B19-1](http://www.ncbi.nlm.nih.gov/sra/ERX276244). Since it is a model species, there is a lot of data associated with it and, as genomic data goes, it is small.

The selected experiment is a paired reads run on an Illumina HiSeq 2000. Paired reads signify that the fragment is read in both directions. This implies we will need two files, one in each direction. Consider:

`$ fastq-dump --split-files ERR302903`

### General

* [Samtools](https://github.com/samtools/samtools) utility for manipulating alignment data.

#### Used in original paper

* [REDItools editing detection package](https://sourceforge.net/projects/reditools) script to analyze RNA editing. \(lang: python\)
* [GOrilla functional analysis](http://cbl-gorilla.cs.technion.ac.il/)

### Visualize/Stats

* [Bioconductor](https://www.bioconductor.org/) provides tools for the analysis and comprehension of high-throughput genomic data.\(lang: R\)

### Infrastructure

* [common workflow language](http://www.commonwl.org/v1.0/) Nice companion to docker.
* Platforms: [Galaxy](https://usegalaxy.org/), [Arvados](https://arvados.org/)

## Research organization

* [The Cephalopod Sequencing Consortium](https://www.cephseq.org)

## Educational Resources

### Sites

* [RNA-seqlopedia](https://rnaseq.uoregon.edu/) from University of Oregon.

### Books

* [Bioinformatics Algorithms](http://bioinformaticsalgorithms.com)
* [Bioinformatics Data Skills - Reproducible and Robust Research with Open Source Tools, by Vince Buffalo](http://vincebuffalo.org/book/)

### MOOCs

* [Coursera bioinformatics specialization](https://www.coursera.org/specializations/bioinformatics) There is a two volume, companion book called Bioinformatics Algorithms\(see book section\). [Many of the video lessons are available on youtube](https://www.youtube.com/channel/UCKSUVRs2N2FdDNvQoRWKhoQ). In particular, there is a chapter on Assemblers - [Chapter 3: How Do We Assemble Genomes? Bioinformatics Algorithms: An Active Learning Approach](https://www.youtube.com/watch?v=vjB6nhOu3BY&list=PLQ-85lQlPqFNGdaeGpV8dPEeSm3AChb6L).
* [Coursera genomic data specialization](https://www.coursera.org/specializations/genomic-data-science)
* If you’re more statistically minded, consider the courses by [Rafael Irizarry on EdX](https://www.edx.org/bio/rafael-irizarry).



