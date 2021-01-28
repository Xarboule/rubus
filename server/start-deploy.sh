#/bin/bash

fail() {
    echo ""
    echo "== DEPLOYMENT FAILED =="
    echo ""
    exit 1
}

if [[ "$#" -ne 1 ]]; then
    echo "Syntax : $0 <raspberry-pi-name>"
    exit
fi

echo "== Start Deploy =="
echo 

read -p "Do you want to deploy the Raspberry Pi named $1? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ -f /pxe/nfs/$1/iiun-cluster-owner ]]
    then
	echo "WARNING : This Pi already belongs to $(cat /pxe/nfs/$1/iiun-cluster-owner)."
	read -p "Do you really want to delete and redeploy this Raspberry Pi? [y/n] " -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    echo ""
	else
	    echo ""
	    echo "Deployment aborted."
	    echo ""
	    exit 1
	fi
    else
	echo "This Pi is available."
    fi
    read -p "Enter new owner name (Syntax : Tom Jedusor => tjedusor): " -r
    echo $REPLY > /pxe/nfs/$1/iiun-cluster-owner
    
    # do dangerous stuff
    sudo mount --bind /pxe/nfs/$1/boot/ /tftp/$1 || fail
    if [[ -f /tftp/$1/disabled/start4.elf ]]
       then
	   sudo mv /pxe/nfs/$1/boot/disabled/* /pxe/nfs/$1/boot/ || fail
    fi
    echo "== Raspberry $1 READY =="
    exit 0
fi

