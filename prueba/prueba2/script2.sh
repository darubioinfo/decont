#!/bin/bash
for url in $(cat data/urls)
do
	bash dowload1.sh $url data
done 
echo

