#!/bin/bash

#Variables definition in downloads
name_samples=$(basename $1)
url_samples=$1
out_samples=$2
#$3  #argument 3 contains the word "yes"
filter_samples=$4 #You can also use the "sed" command

#Download fastq files
wget -P $out_samples $url_samples

#Unzip and filter file for alignment
if [ "$3" = "yes" ]
then
        gunzip -k $out_samples/$name_samples
fi

if [ "$filter_samples" = "filter" ]
then
        echo "filter small RNA..."
	seqkit grep -vrnp '.*small nuclear.*' res/contaminants.fasta > res/free_contaminants.fasta
fi


