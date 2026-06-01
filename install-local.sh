#!/bin/bash

read -p "This action will purge current instalation! Continue? " sure
case $sure in y|Y|yes|YES|Yes) ;; *) exit ;; esac

#wipe
echo "Wiping old installation..."
rm -r ~/aethir
mkdir ~/aethir
cd ~/aethir

#copy and untar
cp /root/scripts/aethir/AethirCheckerCLI-linux-1.0.3.2.tar.gz /root/aethir/aethir.tar
tar -xvf aethir.tar --strip-components=1
rm aethir.tar

echo "Installing service..."
sudo ./install.sh
