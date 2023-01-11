#!/bin/bash

VBoxManage createvm --name=$1 --ostype=Debian11_64 --basefolder=$(pwd) --register

VBoxManage modifyvm $1 --memory=4096 --vram=64 --cpus=2 --nic1 bridged --bridgeadapter1 wlp2s0 --usb on --usbxhci on --uart1 0x3F8 4

VBoxManage storagectl $1 --name "SATA" --add sata --controller IntelAHCI

VBoxManage storageattach $1 --storagectl "SATA" --port 0 --device 0 --type hdd --medium $2

VBoxManage startvm $1
