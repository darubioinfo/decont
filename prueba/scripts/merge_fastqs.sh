contain_samples=$1
out_dir=$2
sample_id=$3

mkdir -p $out_dir
cat $contain_sample/$sample_id*.fastq.gz > $out_dir/$sample_id.fastq.gz

