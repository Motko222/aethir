#!/bin/bash

echo "This action will purge current instalation!"
echo "Copy download link from https://app.aethir.com."
read -p "Link? " url

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
sudo ./install.sh
