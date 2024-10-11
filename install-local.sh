#!/bin/bash

echo "This action will purge current instalation!"

#wipe
echo "Wiping old installation..."
rm -r ~/aethir
mkdir ~/aethir
cd ~/aethir

#copy and untar
cp /root/scripts/aethir/aethir.tar /root/aethir
tar -xvf aethir.tar --strip-components=1
rm aethir.tar

echo "Installing service..."
sudo ./install.sh
