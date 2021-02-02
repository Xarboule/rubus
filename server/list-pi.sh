#!/bin/bash

NFSPATH='/pxe/nfs'
TYPES="chaumont chasseral"

echo "Last update : $(date +"%D %T")"

for type in $TYPES
do
    echo -e "\n=== $type ===\n\n" 
    for i in $(ls -v $NFSPATH/ | grep $type)
    do
	if [ -f $NFSPATH/$i/iiun-cluster-owner ]
	then
	    echo "$i : $(cat $NFSPATH/$i/iiun-cluster-owner)"
	else
	    echo "$i : FREE"
	fi
    done
    echo -e "\n\n"
done

