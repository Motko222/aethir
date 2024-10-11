#!/bin/bash

echo "This action will purge current instalation!"
echo "Check latest version here: https://github.com/AethirCloud/checker-client/tree/main"
read -p "Insert version (e.g. 1.2.0.9): " version

url=https://github.com/AethirCloud/checker-client/raw/main/v$version/AethirCheckerCLI-linux-$version.tar.gz

#wipe
echo "Wiping old installation..."
rm -r ~/aethir
mkdir ~/aethir
cd ~/aethir

#download and unzip
echo "Downloading binary..."
wget $url -O aethir.tar
tar -xvf aethir.tar --strip-components=1
rm aethir.tar

echo "Installing service..."
sudo ./install.sh
