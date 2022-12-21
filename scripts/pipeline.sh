#!/bin/bash

echo "################################################################################"
echo "########## Decontamination of small-RNA sequencing samples from mouse ##########"
echo "################################################################################"
echo "##### by David Rubio #####  Starting pipeline at $(date +'%d %h %y, %r') ##########"
echo "################################################################################"

echo -e "\n\nDonwloading samples...\n\n"
for url in $(cat data/urls)
do
        bash scripts/download.sh $url data
done
echo -e "\n\nDone\n\n"

echo -e "\n\nDownloading the fasta file, unzipping and filtering...\n\n"
bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes "filter"
echo -e "\n\nDone\n\n"


echo -e "\n\nCreating the index for alienation...\n\n"
bash scripts/index.sh res/free_contaminants.fasta res/contaminants_idx
echo -e "\n\nDone\n\n"

echo -e "\n\nMerging the samples...\n\n"
mkdir -p out/merged
for sid in $(ls data/*.gz | cut -d "-" -f1 | sed 's:data/::' | sort | uniq)
do
        bash scripts/merge_fastqs.sh data out/merged $sid
done
echo -e "\n\nDone\n\n"

echo -e "\n\nRunning cutadapt...\n\n" #remove adapters
mkdir -p out/trimmed
mkdir -p log/cutadapt
chmod 777 out/merged/*.gz
for  id_sample in $(ls out/merged/*.gz | cut -d "/" -f3 | cut -d "." -f1)
do cutadapt \
        -m 18 \
        -a TGGAATTCTCGGGTGCCAAGG \
        --discard-untrimmed \
        -o out/trimmed/${id_sample}.trimmed.fastq.gz out/merged/${id_sample}.fastq.gz > log/cutadapt/${id_sample}.log
done
echo -e "\n\nDone\n\n"

echo -e "\n\nRunning STAR for trimmed files...\n\n"
for fname in out/trimmed/*.fastq.gz
do
    sample_id=$(basename $fname .trimmed.fastq.gz)
    mkdir -p out/star/${sample_id}
    STAR \
        --runThreadN 4 \
        --genomeDir res/contaminants_idx \
        --outReadsUnmapped Fastx  \
        --readFilesIn out/trimmed/${sample_id}.trimmed.fastq.gz \
        --readFilesCommand gunzip -c  \
        --outFileNamePrefix out/star/${sample_id}/
done
echo -e "\n\nDone\n\n"


echo -e "\n\nGenerating log...\n\n"
bash scripts/log.sh
echo -e "\n\nDone\n\n"

echo -e "\n\nFinally exporting file with environment information\n\n"
#conda env export --from-history > envs/decont.yaml
echo -e "\n\n###### Pipeline finished at $(date +'%H:%M:%S') ######\n\n"

