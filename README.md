# RPi2RTPMserver
Some bash script to create a streaming radio to broadcast some music to YouTube or other RTMP server with a looping video and the song's cover.

Those files use some tools to make that possible. You have the list with all the tools and their websites in the **Prerequisites** section.

This project need a lot of optimizations and rework to make it easier to configure. Also, there are a lot of features we can add to the project.
# Prerequisites
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
## Installing prerequisites from repositories
```
sudo apt update && sudo apt install git ffmpeg mplayer vlc python3-pip libimage-exiftool-perl jq nkf pavucontrol -y
```
## Installing sacad
```
sudo pip3 install sacad
```
## Cloning tweet.sh
```
git clone https://github.com/piroor/tweet.sh
```
After cloning that repository, you have to copy **tweet.sh** and **tweet.client.key** to the same folder of **play_audio.sh**.

You can get instructions about how to configure tweet.sh in its [GitHub](https://github.com/piroor/tweet.sh).
## Configuring PulseAudio
After You Install everything, You have to configure PulseAudio to work properly in Raspbian, so FFmpeg can get the audio from the sound card. To improve performance You have to add a parameter in **/etc/pulse/default.pa** as following. First You have to open the file with a text editor, like **nano**
```
sudo nano /etc/pulse/default.pa
```
Then You have to find the following lines, You can use **Ctrl+W** to search those lines:
```
### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
load-module module-udev-detect
```
And add **tsched=0**  in the third line, having this as result:
```
### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
load-module module-udev-detect tsched=0
```
After that, You should reboot your Raspberry Pi to make sure everything works as expected.
# Playing songs
Once You reboot your Raspberry Pi, You can use **play_audio.sh** to start playing songs in the Raspberry Pi. You can define where the songs are in the variable **FOLDER**. The script will look for **mp3** files on that folder and play them with **Mplayer** using a normalizer filter to get always the same volume between files.
# Running video streamer
Once You have the player working, It's time to start the video streamer and send the video to your RTMP server. By default, It's configured to send that video to YouTube, but You can change the server URL to stream to other services like Facebook Live, Twitch or Mixer.

First of all, check all the configuration variables defined in the file **stream.sh** and then, run that using the command **./stream.sh**. You can modify the file **marquee.txt** to change the marquee text in the stream.
# ToDo things
- [ ] Set cover position depending on video dimensions
- [ ] Better file randomizer
# YouTube ended LiveStream test
[![YouTube ended LiveStream test](https://img.youtube.com/vi/YBMZCERdZpk/0.jpg)](https://www.youtube.com/watch?v=YBMZCERdZpk "YouTube ended LiveStream test")
# Demo files
- **video.mp4** [Motion Places - Free Stock Video](https://www.pexels.com/@motion-places-free-stock-video-701499)
- **Jon Worthy and the Bends - You Afraid.mp3** [Free Music Archive: Jon Worthy and the Bends - You Afraid](https://freemusicarchive.org/music/Jon_Worthy_and_the_Bends/Only_A_Dream/You_Afraid)
- **Mild Wild - Line Spacing.mp3** [Free Music Archive: Mild Wild - Line Spacing](https://freemusicarchive.org/music/Mild_Wild/a_Line_Spacing_b_Say_Goodnight/Line_Spacing)
- **Robert John - Slinky.mp3** [Free Music Archive: Robert John - Slinky](https://freemusicarchive.org/music/Robert_John/2019041994432122/Slinky_1461)

All video and audio files are used only for educational propuses. No copyright infringment intended. You can check flies liceses on their links.
