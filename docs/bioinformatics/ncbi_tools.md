The [National Center for Biotechnology
Information(NCBI)](https://www.ncbi.nlm.nih.gov/) contains an amazing
plethora of bioinformatics information.  Raw Next Generation
Sequencing (NGS) data is found on the [Sequence Read Archive
(SRA)](https://www.ncbi.nlm.nih.gov/sra) section.

The Sequence Read Archive basically includes intensity, read and
alignment data. All this data requires a lot of space. We only want to
extract the two fastq files representing the reads. NCBI provides a
collection of command line tools called the [SRA
toolkit](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)
to extract fastq files. We will use the fastq-dump command to retrieve
the data we require.

As an example, I selected [ERX276244: Whole Genome Sequencing of
fungal endophyte
sp. D3-2B19-1](http://www.ncbi.nlm.nih.gov/sra/ERX276244). Since it is
a model species, there is a lot of data associated with it and, as
genomic data goes, it is smalle.
 
The selected experiment is a paired reads run on an Illumina HiSeq
2000. Paired reads signify that the fragment is read in both
directions. This implies we will need two files, one in each
direction. Consider:

$ fastq-dump --split-files ERR302903

