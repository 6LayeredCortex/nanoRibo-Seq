#/bin/sh

#Takes in a path to a gtf, and an outfile
#1) adds "chr" to all lines except the header (assumes a 5-line header).
#2) changes tabs to spaces for the 9th field and beyond.
#Turns out this is super critical, because some ENSEMBL GTFs have tabs 
#instead of spacers as delimiters in the 9th field (attributes)
#which causes the gene_id field to be read as empty, and a trainwreck in featureCounts

gtf=$1
gtfOut=$2

awk 'OFS="\t" {if (NR > 5) $1="chr"$1; print}' $gtf | sed 's/\t/ /9g' >  $gtfOut
