#!/bin/bash

if [ $# != 2 ]
  then
    echo "Provide a name for the virtual machine and a path to an Ubuntu live ISO file"
fi

# AUX_BASE_PATH="$(mktemp -d $(pwd)/iso-linux-temp-XXX)"

# VBoxManage createvm --name=$1 --default --ostype=Ubuntu22_LTS_64 --basefolder=$(pwd) --register

VBoxManage createvm --name=$1 --default --ostype=Debian11_64 --basefolder=$(pwd) --register

VBoxManage createhd --filename "$(pwd)/$1/$1.vdi" --size 32768

VBoxManage storagectl $1 --name "$1-SATA" --add sata --controller IntelAHCI

VBoxManage storageattach $1 --storagectl "$1-SATA" --port 0 --device 0 --type hdd --medium /VirtualBox/$1/$1.vdi

VBoxManage modifyvm $1 --memory=4096 --vram=64 --cpus=2 --nic=bridged --usb=on --usbxhci=on

# VBoxManage unattended install $1 --iso=$2 --auxiliary-base-path="$AUX_BASE_PATH"/ --user=ap --password=password --locale=en_GB --hostname=ubuntu-ap-vm.local 

VBoxManage unattended install $1 --iso=$2 --user=ap --password=password --locale=en_GB --hostname=ubuntu-ap-vm.local 

# sed -i 's/^default vesa.*/default install/' "$AUX_BASE_PATH"/isolinux-isolinux.cfg

VBoxManage startvm $1
