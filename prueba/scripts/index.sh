genome_contaminant = $1
outdir = $2
STAR \
    --runThreadN 5 \
    --runMode genomeGenerate \
    --genomeDir $outdir \
    --genomeFastaFiles $genomr_contaminant \
    --genomeSAindexNbases 9
echo

