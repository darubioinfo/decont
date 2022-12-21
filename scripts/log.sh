#!/bin/bash


for fname in log/cutadapt/*.log
do
    sample_id=$(basename $fname .log)
    echo "------------------------Sample → ${sample_id}------------------------" >> log/pipeline.log
echo "
CUTADAPT:" >> log/pipeline.log
    cat log/cutadapt/${sample_id}.log | \
grep -e "Reads with adapters" >> log/pipeline.log
echo "
STAR: " >> log/pipeline.log
    cat out/star/${sample_id}/Log.final.out | \
    egrep "reads %|% of reads mapped to (multiple|too)" >> log/pipeline.log
    echo >> log/pipeline.log
done


