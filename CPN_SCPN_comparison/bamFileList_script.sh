#!/bin/sh

folder=$1
#bamFileName=$2

#ls ${folder}
#echo ${folder}/*.bam
bamFileList=$(ls -p ${folder} | tr '\n' ',' | sed 's/,*$//g')
echo $bamFileList
