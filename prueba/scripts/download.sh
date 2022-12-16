#DOWLOAD by David
#create script variables
url_samples=$1
name_samples=$(basename $1) #keep the filename only from a path (in this case C57BL_...)
out_samples=$2
uncompress_samples=$3  #argument 3 contains the word "yes"
filter_samples=$4

echo "Downloading samples..."

wget -P $out_samples -i $url_samples

echo

if ["$uncompress_samples" == "yes"]
then
	echo "Uncompressing samples..."
	echo
	gupiz -k $our_samples/$name_samples
fi
echo


