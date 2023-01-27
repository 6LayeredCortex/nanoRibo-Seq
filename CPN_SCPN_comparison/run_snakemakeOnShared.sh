#!/bin/sh
#SBATCH -n 1                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 1-0:00          # Runtime in D-HH:MM, minimum of 1 hr
#SBATCH -p shared   # Partition to submit to
#SBATCH --mem=15000           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -e snakemakeOnCluster_%j.err  # File to which STDERR will be written, %j inserts jobid
#SBATCH -o snakemakeOnCluster_%j.out
#SBATCH --mail-type=END,FAIL

module load Anaconda
source activate snakemake
./run_snakemake.sh live


