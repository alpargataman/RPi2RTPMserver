#! /bin/bash
# ¿Why VLC?
echo "Installing dependencies..."
sudo apt-get update
sudo apt update && \
sudo apt install \
git \
ffmpeg \
mplayer \
vlc \
python3-pip \
libimage-exiftool-perl \
jq \
nkf \
pavucontrol \
imagemagick -y

echo "Installing pip packages"
sudo pip3 install sacad

echo "Done!"