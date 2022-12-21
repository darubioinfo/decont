#!/bin/bash
mkdir -p res/contaminants_idx
freecontaminants=$1
out_samples=$2

        STAR \
                --runThreadN 5 \
                --runMode genomeGenerate \
                --genomeDir $out_samples \
                --genomeFastaFiles $freecontaminants \
                --genomeSAindexNbases 9

