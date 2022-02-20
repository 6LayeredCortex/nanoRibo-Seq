gtf=$1 #path to gtf
bamDir=$2 #directory containing bams
outFile=$3 #output file

#first run on the bam files with filtered unique reads. Use the -R option to generate the output for each bamFile. 
#The output gets overwritten for each annotation because featureCounts just slaps ".featureCounts" on the end of
#the read information file
#So do the filtering all in one step.

for anno in "CDS" "three_prime_utr" "five_prime_utr"; do
	echo "doing $anno"
	featureCounts -a $gtf -t $anno -o ${bamDir}/featureCounts_${anno}_summary.txt -R ${bamDir}/*sortedByCoord.out*.bam
	for originalBAM in ${bamDir}/*sortedByCoord.out*.bam; do
		#Pull out the assigned reads from the read information file produced by featureCounts
		samtools view -H $originalBAM >  ${originalBAM}_${anno}_Assigned.sam
		echo "finding assigned reads..."
		grep "Assigned" ${originalBAM}.featureCounts | cut -f1 > ${originalBAM}_${anno}_AssignedReadNames.txt
		echo "pulling out assigned reads from bamFile..."
		samtools view $originalBAM | fgrep -w -f ${originalBAM}_${anno}_AssignedReadNames.txt >> ${originalBAM}_${anno}_Assigned.sam
		echo "converting back to BAM format..."
		samtools view -bS ${originalBAM}_${anno}_Assigned.sam > ${originalBAM}_${anno}_Assigned.bam
		rm ${originalBAM}_${anno}_Assigned.sam
		rm ${originalBAM}_${anno}_AssignedReadNames.txt
		echo "done"
		#count the length distributions of the aligned reads:
		samtools view ${originalBAM}_${anno}_Assigned.bam | awk '{print length($10)}' |sort -n | uniq -c  > ${originalBAM}_${anno}_lengths.txt
		rm ${originalBAM}_${anno}_Assigned.bam
	done
done

for anno in lincRNA snoRNA snRNA chrMT; do
	echo "doing $anno"
	gtfName=$(basename $gtf .gtf)
	echo $gtfName
	echo "gtf is $gtf"
	if [[ $anno == "chrMT" ]]; then
		grep "^${anno}" $gtf > ${bamDir}/${gtfName}_${anno}.gtf
		featureCounts -a ${gtfName}_${anno}.gtf -t CDS -o ${bamDir}/featureCounts_${anno}_summary.txt -R ${bamDir}/*sortedByCoord.out*.bam
	else
	grep $anno $gtf > ${bamDir}/${gtfName}_${anno}.gtf
	featureCounts -a ${bamDir}/${gtfName}_${anno}.gtf -o ${bamDir}/featureCounts_${anno}_summary.txt -R ${bamDir}/*sortedByCoord.out*.bam
	fi
	for originalBAM in ${bamDir}/*ortedByCoord.out*.bam; do
		#Pull out the assigned reads from the read information file produced by featureCounts
		samtools view -H $originalBAM >  ${originalBAM}_${anno}_Assigned.sam
		echo "finding assigned reads..."
		grep "Assigned" ${originalBAM}.featureCounts | cut -f1 > ${originalBAM}_${anno}_AssignedReadNames.txt
		echo "pulling out assigned reads from bamFile..."
		samtools view $originalBAM | fgrep -w -f ${originalBAM}_${anno}_AssignedReadNames.txt >> ${originalBAM}_${anno}_Assigned.sam
		echo "converting back to BAM format..."
		samtools view -bS ${originalBAM}_${anno}_Assigned.sam > ${originalBAM}_${anno}_Assigned.bam
		rm ${originalBAM}_${anno}_Assigned.sam
		rm ${originalBAM}_${anno}_AssignedReadNames.txt
		echo "done"
		#count the length distributions of the aligned reads:
		samtools view ${originalBAM}_${anno}_Assigned.bam | awk '{print length($10)}' |sort -n | uniq -c > ${originalBAM}_${anno}_lengths.txt
		rm ${originalBAM}_${anno}_Assigned.bam
	done
done

if test -f ${outFile}; then
rm ${outFile}
fi


echo "count,length,samps,anno" > ${outFile}
 
for anno in CDS three_prime_utr five_prime_utr snoRNA snRNA lincRNA chrMT; do
	for lengthDistro in ${bamDir}/*${anno}_lengths.txt; do
		sampName=$(echo $lengthDistro | cut -f2 -d"/" | cut -f1 -d"." )
		#echo $sampName
		awk -v sampName=$sampName -v anno=$anno 'BEGIN{OFS=","}{print $1, $2, sampName, anno}' $lengthDistro >> ${outFile}
	done
done


