#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with sudo (or as root)" 1>&2
   exit 1
fi

fail() {
    echo
    echo "== DEPLOYMENT FAILED =="
    echo
    exit 1
}


if [[ "$#" -ne 1 ]]; then
    echo "Syntax : $0 <raspberry-pi-name>"
    exit
fi

echo "== ADD NEW RASPBERRY PI =="
echo



read -p "Do you want to deploy the Raspberry Pi named $1 ? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    sudo mkdir /tftp/$1 || fail
    echo "Copy the NFS-TEMPLATE folder... (can take some time)"
    sudo cp -ar /pxe/nfs/NFS-TEMPLATE /pxe/nfs/$1 || fail
    sudo echo "$1" > /pxe/nfs/$1/etc/hostname || fail
    sudo sed -i.back /raspberrypi/d /pxe/nfs/$1/etc/hosts || fail
    sudo echo -e "127.0.1.1\t$1" >> /pxe/nfs/$1/etc/hosts || fail
    sudo echo "console=serial0,115200 console=tty1 root=/dev/nfs nfsroot=172.29.0.100:/pxe/nfs/$1,vers=3 rw ip=dhcp rootwait elevator=deadline" > /pxe/nfs/$1/boot/disabled/cmdline.txt || fail

    
    sudo echo "/pxe/nfs/$1 *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports || fail
    echo
    echo "WARNING : You need to restart rpcbind and nfs-kernel-server services"
    echo
    echo "== RASPBERRY SUCCESSFULLY ADDED =="
    
fi


