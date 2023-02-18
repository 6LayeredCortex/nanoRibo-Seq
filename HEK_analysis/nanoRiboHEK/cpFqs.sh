#!/bin/sh

fqPath="/n/macklis_lab/users/jfroberg/fastqs/Subpop_HEK"
mkdir fastq

for idx in JF216_S25 JF217_S26 JF218_S27 JF219_S28 JF220_S29 JF221_S30; do
	for reed in R1 R2; do
		cmd="cp ${fqPath}/${idx}*${reed}*.fastq.gz fastq"
		echo $cmd
		$cmd
	done
done


