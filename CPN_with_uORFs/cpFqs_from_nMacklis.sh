#!/bin/sh

mkdir merged
#copies over all the CPN files. RiboProfTest5 only has the single hemisphere ones if you prefer them.
for idx in JF39_S4 JF43_S8 JF45_S10; do
	for reed in R1 R2; do
		fqPath="/n/macklis_lab/users/jfroberg/fastqs/RiboProfTest4"
		cmd=$(cp ${fqPath}/${idx}*${reed}*.fastq.gz merged/${idx}_${reed}.fastq.gz)
		echo $cmd
	done
done

for idx in JF124_S1 JF125_S2 JF126_S3 JF127_S4 JF128_S5 JF129_S6 JF130_S7 JF131_S8 JF132_S9 JF133_S10; do
	for reed in R1 R2; do
                fqPath="/n/macklis_lab/users/jfroberg/fastqs/RiboProfTest5/RiboProf"
                cmd=$(cp ${fqPath}/${idx}*${reed}*.fastq.gz merged/${idx}_${reed}.fastq.gz)
                echo $cmd
        done
done


