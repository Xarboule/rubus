#!/bin/bash

umount /tftp/$1
rm -r /tftp/$1
rm -r /pxe/nfs/$1
sed -i /$1/d /etc/exports
