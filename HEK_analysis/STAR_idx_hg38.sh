#!/bin/sh

#SBATCH -t 0-4:00
#SBATCH -p test
#SBATCH --mem=64G
#SBATCH -e STAR_hg38.err
#SBATCH -o STAR_hg38.out
#SBATCH -n 8
#SBATCH --mail-type=ALL

#Provide path to FASTAs and GTF, and genomeDir
fastaPath="/n/macklis_lab/users/jfroberg/hg38/*.fa"
gtf="/n/macklis_lab/users/jfroberg/gtfs/Homo_sapiens.GRCh38.109_chrNamed_headFix.gtf"
genomeDir="/n/macklis_lab/users/jfroberg/hg38/STAR2.6.0"

#Load STARv2.7.1
module load GCC/7.3.0-2.30 OpenMPI/3.1.1 STAR/2.6.0c-fasrc01

#make genomeDir
mkdir $genomeDir



cmd="STAR \
	--runThreadN 8
	--runMode genomeGenerate
	--genomeDir $genomeDir
	--genomeFastaFiles $fastaPath
	--sjdbGTFfile $gtf
"
echo $cmd
$cmd

