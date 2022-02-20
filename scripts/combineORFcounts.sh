#!/bin/sh

folder=$1
outFile=$2

for file in ${folder}/*counts.txt; do
	sampName=$(basename $file .ORF_counts.txt)
	grep "ENS" $file > ${file}.geneFiltered
	awk -v sampName=$sampName '{print $1,$2,sampName}' ${file}.geneFiltered > "${folder}/${sampName}.tidy.txt"
	#awk -v sampName=$sampName 'NR==1 { print "ORF_ID", "Counts" , "Sample" }; 1' "${folder}/${sampName}.tidy.txt" > temp && mv temp "${folder}/${sampName}.tidy.txt"
done

echo "ORF_ID Counts Sample" > tmp.txt
cat ${folder}/*.tidy.txt >> tmp.txt
mv tmp.txt $outFile

#cut -f2 -d" " ORFcounts/*counts.txt | paste > data.txt

