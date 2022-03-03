# nanoRibo-Seq

We present two workflows (each with its own directory):
1) RNaseTitration
2) CPN_w_uORFs

Both utilize Snakemake workflow management. The "Snakefile" contains the input, output, parameters needed to generate the shell commands that run each step ("rule"). 
The sample names, and parameters for each rule are defined in the configuration file, "config.yaml". The paths to scripts and gtf files in the example config.yaml files are
relative paths, and can be replaced with the appropriate paths to the same scripts on your system. The "cluster.json" file contains the "slurm" batch submission parameters used foreach rule. 
Snakemake carries out workflow management, based on the input and output dependencies for each rule in the Snakefile. It builds a "directed acyclic graph", which is the 
sequence of rules that must be run for each sample given the provided input and rules for generating output. 
It expands parameters and sample names read in from the config.yaml file, builds batch jobs according to the shell parameters for each rule, and handles slurm submission for these jobs.

The presented workflows and outputs were generated using these exact workflows on the Harvard FASRC Cannon High Performance Cluster. They are examples/representative workflows, 
and can likely be adapted to similar SLURM-based high performance environments. 

Descriptions of the two workflows:

**1) RNaseTitration: **
Used with the four RNase Titration samples to generate Figure 3. Can be used to generate similar "QC" figures for any nanoRibo-seq data sets

Begins with a directory ("merged") containing the fastq.gz files for each sample (R1 and R2).

rule filter_12nt: Uses cutadapt (v1.13) to remove the small minority of reads <12 nt long (failure to do so causes a fatal error in the next step.

rule umi_extract: Uses python package UMI-tools (v1.0.1) (https://github.com/CGATOxford/UMI-tools) to extract 
the Unique Molecular Identifier (UMI) present in the first 12-nt of R2.

rule cutadapt: Runs cutadapt (v1.13) to remove the 3' adapter sequence (cutadapt -a AACTGTAGGCACCATCAAT) from R1.

rule rRNA_align: Align R1 reads to rRNA using STAR (v2.6), extract the reads that do not map to rRNA.

rule transcriptome_align: Perform transcriptome alignment to mouse transcriptome using STAR (v2.6) and the *gtf file*. 

Transcriptome alignment ALSO produces genome alignments, useful for visualization (and used to make the IgV shots).

rule dedup: remove PCR duplicates using UMI-tools (v1.0.1), by collapsing reads with the same alignment and identical barcodes (--method=unique).

rule dedup_transcriptome: remove PCR from transcriptome alignment duplicates using UMI-tools (v1.0.1), by collapsing reads with the same alignment and identical barcodes (--method=unique).

rule featureCounts: run subRead:featureCounts to perform gene-level counting of all reads mapping to CDS, three_prime_utrs, and five_prime_utrs separately.

rule lengthDistros: runs shell script (using samtools) to generate read length distributions ( over CDS, 5' and 3' UTRs. Also runs featureCounts to make length distro over snRNA, snoRNA, lncRNA.

rule featureCounts_noDedup: featureCounts without read deduplication first. Actually not used for anything, legacy code.

rule Rmd: Takes in the featureCounts, lengthDistro outputs and runs them through an R-markdown (LengthsCountsCov_RiboWaltz_v3.Rmd) to produce the QC figures, such as Figure 3.This rule actually first runs a shell script ("compile_v2.r") that configures the R- environment for the R-markdown script to run. 
The R-markdown script also runs RiboWaltz (https://github.com/LabTranslationalArchitectomics/riboWaltz), which performs the detailed P-site analysis. 

**2) CPN_w_uORFs:**
**Used with all CPN samples to generate Figure 7. 
Same as alignment and QC workflow as the Rnase Titration, but also includes code to run RiboCode to identify all translated ORFs,
and an R-markdown file that analyzes the output of the RiboCode ORF analysis**

rule RiboCode: Takes in reads aligned to genome, runs python package RiboCode (https://github.com/xryanglab/RiboCode) to identify translated ORFs.
rule Rmd: Takes in the featureCounts, lengthDistro outputs and runs them through an R-markdown (LengthsCountsCov_RiboWaltz_v6_nointeract.Rmd) 
to produce the QC figures, such as Figure 3.This rule actually first runs a shell script ("compile_v2.r") that configures the R- environment for the R-markdown script to run. 
The R-markdown script also runs RiboWaltz (https://github.com/LabTranslationalArchitectomics/riboWaltz), which performs the detailed P-site analysis.
Parses the output of RiboCode to plot ORF length distributions, start codon frequencies, T.E. distributions. 



