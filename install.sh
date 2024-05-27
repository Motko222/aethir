#!/bin/bash

echo "This action will purge current instalation!"
read -p "URL? " url

#wipe
echo "Wiping old installation..."
rm -r ~/aethir
mkdir ~/aethir
cd ~/aethir

#download
echo "Downloading binary..."
wget $url -O aethir.tar
tar -xvf aethir.tar --strip-components=1
rm aethir.tar

echo "Installing service..."
./install.sh
