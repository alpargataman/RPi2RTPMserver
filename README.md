# RPi2RTPMserver
Some bash script to create an  streaming radio to broadcast some music to YouTube or other RTMP with video and cover
# Requeriments
- From repositories
  - [Git](https://git-scm.com/)
  - [FFmpeg](https://www.ffmpeg.org/)
  - [Mplayer](http://www.mplayerhq.hu/)
  - [VLC](https://www.videolan.org/)
  - [Exiftool](https://exiftool.org/)
  - [ImageMagik](https://imagemagick.org/index.php)
  - [jq](https://stedolan.github.io/jq/)
  - [nkf](http://nkf.osdn.jp/)
  - [PulseAudio](https://gitlab.freedesktop.org/pulseaudio/pulseaudio)
- Python
  - [sacad](https://github.com/desbma/sacad)
- GitHub
  - [tweet.sh](https://github.com/piroor/tweet.sh)
# Installing requeriments from repositories
```
sudo apt update && sudo apt install git ffmpeg mplayer vlc python3-pip libimage-exiftool-perl jq nkf pavucontrol -y
```
# Installing sacad
```
sudo pip3 install sacad
```
# Cloning tweet.sh
```
git clone https://github.com/piroor/tweet.sh
```
# Configuring PulseAudio
ToDo
# Playing songs
ToDo
# Running video streamer
ToDo
# ToDo things
- [ ] Set cover position depending of video dimensions
