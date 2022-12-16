echo "Donwloading samples..."
for url in $(cat data/urls)
do
	bash download.sh $url data yes
done

