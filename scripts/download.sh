# This script should download the file specified in the first argument ($1),
# place it in the directory specified in the second argument ($2),
# and *optionally*:
# - uncompress the downloaded file with gunzip if the third
#   argument ($3) contains the word "yes"
# - filter the sequences based on a word contained in their header lines:
#   sequences containing the specified word in their header should be **excluded**
# Example of the desired filtering:
#   > this is my sequence
#   CACTATGGGAGGACATTATAC
#   > this is my second sequence
#   CACTATGGGAGGGAGAGGAGA
#   > this is another sequence
#   CCAGGATTTACAGACTTTAAA
#If $4 == "another" only the **first two sequence** should be output
#---------------------------------------------------------------------

#DOWLOAD by David

#create script variables
url_samples=$1
name_samples=$(basename $1) #keep the filename only from a path (in this case C57BL_...)
out_samples=$2
$3  #argument 3 contains the word "yes"
filter_samples=$4

echo "Downloading samples..."

wget -P $out_samples $url_samples

echo

if [ "$3" == "yes" ]
then
	echo "Uncompressing samples..."
       gunzip -k $our_samples/$name_samples
fi

#Filter small nuclear sequences

id_sample=$(basename $url_samples .gz) 

if ["$4" == "Small_nuclear_RNA"] 
then
seqkit grep -vrnp "Small_nuclear_RNA" $name_samples/filter_$id_sample > $out_samples/$id_sample #search sequences by ID/name/sequence mismatch allowed
fi
echo

