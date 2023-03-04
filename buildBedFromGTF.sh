#!/bin/sh
#take in a gtf file, with annotated five_prime and three_prime utrs and convert the coordinates to bed6 format

gtfIN=$1
#grep $anno Mus_musculus.GRCm38.95_chrNamed_headFix.gtf | head -n10 > test.gtf
#cut -f1 -d";" test.gtf > test.gtf_simpleName
#sed 's/gene_id//g' test.gtf_simpleName | sed 's/\"//g' > test.gtf_simpleName2 
#awk 'BEGIN {FS="\t"}; {print $1 FS $4 FS $5 FS $9 FS $6 FS $7}' test.gtf_simpleName2 > test.bed
#cut -f1,4,5 test.gtf > test.bed

for anno in three_prime_utr five_prime_utr; do
	echo $anno
	grep $anno $gtfIN > ${anno}.gtf
	cut -f1 -d";" ${anno}.gtf > ${anno}.gtf_simpleName
	sed 's/gene_id//g' ${anno}.gtf_simpleName | sed 's/\"//g' > ${anno}.gtf_simpleName2
	echo "chr	start	end	Geneid	score	strand" > ${anno}.bed
	awk 'BEGIN {FS="\t"}; {print $1 FS $4 FS $5 FS $9 FS $6 FS $7}' ${anno}.gtf_simpleName2 >> ${anno}.bed
done

rm *simpleName*
