#! /bin/bash

# This script installs all dependencies for the project
# It is run by the install script
# It is run as root
# Works on debian based systems

echo "Installing dependencies..."
sudo apt-get update
sudo apt update && \
sudo apt install \
ffmpeg \
mplayer \
vlc \
python3-pip \
libimage-exiftool-perl \
jq \
nkf \
pavucontrol \
imagemagick -y

echo "Installing pip packages..."
sudo pip3 install sacad

echo "Done!"
