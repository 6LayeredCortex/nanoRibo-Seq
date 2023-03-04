#!/bin/sh

mode=$1
module load bedtools2/2.26.0-fasrc01

if [[ $mode == "copy" ]]; then
cp /n/macklis_lab/users/jfroberg/mtrDmm10/mm10_nucMT_fasta_from_ucsc/mm10_nucMT.fa .
fi
if [[ $mode == "test" ]]; then
bedtools getfasta -s  -fi mm10_nucMT.fa -bed Xist.bed
fi

if [[ $mode == "extract" ]]; then

mkdir extracted_utrs
for anno in 5UTR 3UTR; do
	for trans_cat in CPNandSCPN_TE_high_longest CPNandSCPN_TE_low_longest CPNandSCPN_TE_high CPNandSCPN_TE_low; do
		echo "${anno}_${trans_cat}"
		bedtools sort -i ${trans_cat}_${anno}.bed > ${anno}_${trans_cat}.sorted.bed
		bedtools merge -i ${anno}_${trans_cat}.sorted.bed -s > ${anno}_${trans_cat}_merged.bed
		bedtools getfasta -s -name -fi mm10_nucMT.fa -bed ${anno}_${trans_cat}_merged.bed > extracted_utrs/${anno}_${trans_cat}.fasta
	done
done
fi

