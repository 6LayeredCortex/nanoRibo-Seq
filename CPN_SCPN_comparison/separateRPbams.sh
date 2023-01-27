#!/bin/sh

#script to copy out the RP bams from others for input into RiboWaltz

metadata=$1
inDir=$2
bamSuffix=$3
RPdir=$4
outscript=$5

mkdir $RPdir
rm -r $outscript

awk -v inDir=$inDir -v bamSuffix=$bamSuffix -v RPdir=$RPdir -F"," '{
#print $2
if($2 == "RP") {
print "cp "inDir"/"$1"."bamSuffix" " RPdir"/"$1".bam"
}
}' $metadata > $outscript

chmod u+x $outscript

cat $outscript | while read cmd; do
	echo $cmd
	$cmd
done






