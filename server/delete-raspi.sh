#!/bin/bash


if [[ "$#" -ne 1 ]]; then
    echo "Syntax : $0 <raspberry-pi-name>"
    exit
fi

read -p "Do you want to REMOVE the Raspberry Pi named $1 from the cluster? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo umount /tftp/$1
    sudo rm -r /tftp/$1
    sudo rm -r /pxe/nfs/$1
    sudo sed -i /$1/d /etc/exports
    echo ""
    echo "Raspberry deleted."
    echo ""

fi
