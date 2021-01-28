#!/bin/bash

if [[ "$#" -ne 1 ]]; then
    echo "Syntax : $0 <raspberry-pi-name>"
    exit
fi

echo "== FREE RASPBERRY =="
echo 

read -p "Do you want to FREE the Raspberry Pi named $1? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo rm /pxe/nfs/$1/iiun-cluster-owner
fi

echo ""
echo "Done."
echo ""
