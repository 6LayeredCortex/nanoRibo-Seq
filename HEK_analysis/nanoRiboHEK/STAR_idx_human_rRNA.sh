#!/bin/sh

#SBATCH -t 0-4:00
#SBATCH -p test
#SBATCH --mem=64G
#SBATCH -e STAR_human_rRNA.err
#SBATCH -o STAR_human_rRNA.out
#SBATCH -n 8
#SBATCH --mail-type=ALL

#Provide path to FASTAs and GTF, and genomeDir
fastaPath="/n/macklis_lab/users/jfroberg/hg38/human_rRNA/*.fa"
genomeDir="/n/macklis_lab/users/jfroberg/hg38/human_rRNA/STAR2.6.0"

#Load STARv2.6.0
module load GCC/7.3.0-2.30 OpenMPI/3.1.1 STAR/2.6.0c-fasrc01

#make genomeDir
mkdir $genomeDir



cmd="STAR \
	--runThreadN 8
	--runMode genomeGenerate
	--genomeDir $genomeDir
	--genomeFastaFiles $fastaPath
	--genomeSAindexNbases 5
"
echo $cmd
$cmd

