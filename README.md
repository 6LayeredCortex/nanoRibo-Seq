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
1) RNaseTitration:


2) CPN_w_uORFs:

