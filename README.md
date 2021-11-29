# RPi2RTPMserver

Some bash script to create a streaming radio to broadcast some music to YouTube or other RTMP server with a looping video and, song's cover and information.

Those files use some tools to make that possible. You have the list with all the tools and their websites in the **prerequisites** section.

- [RPi2RTPMserver](#rpi2rtpmserver)
  - [Prerequisites (Step 1)](#prerequisites-step-1)
    - [Configuring PulseAudio](#configuring-pulseaudio)
  - [Playing songs (Step 2)](#playing-songs-step-2)
  - [Running video streamer (Step 3)](#running-video-streamer-step-3)

## Prerequisites (Step 1)

* **ffmpeg**: process the whole stream
* **mplayer**: plays audio files
* **python3-pip**: needed to install sacad
* **sacad**: gets album cover
* **exiftool**: gets song information
* **jq**: tranforms json files
* **nkf**: network kanji filter
* **Pulse Audio**: needed to get a better performance
* **imagemagick**: converts and resizes album covers

To install all dependencies just execute `install_deps.sh` as super user.

```bash
sudo chmod 755 *.sh
sudo ./install_deps.sh
```

### Configuring PulseAudio

After You Install everything, You have to configure PulseAudio to work properly in Raspbian, so ffmpeg can get the audio from the sound card. To improve performance You have to add a parameter in **/etc/pulse/default.pa** as following. First You have to open the file with a text editor, like **nano**

```bash
sudo nano /etc/pulse/default.pa
```

Then You have to find the following lines, You can use **Ctrl+W** to search those lines:

```bash
### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
load-module module-udev-detect
```

And add **tsched=0**  in the third line, having this as result:

```bash
### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
load-module module-udev-detect tsched=0
```

After that, You should reboot your Raspberry Pi to make sure everything works as expected.

## Playing songs (Step 2)

Once You reboot your Raspberry Pi, You can use **play_audio.sh** to start playing songs in the Raspberry Pi. You can define where the songs are in the variable **FOLDER**. The script will look for **mp3** files on that folder and play them with **Mplayer** using a normalizer filter to get always the same volume between files.

```bash
sudo ./play_audio.sh
```

Yo can also change the cover size specified on **COVER_SIZE**. In addition, if you do not want to download the cover from the internet you just have to configure **INTERNET_COVER** as ``0``, otherwise ``1``.

## Running video streamer (Step 3)

Once You have the player working, It's time to start the video streamer and send the video to your RTMP server especified on **RTMP_URL**. By default, It's configured to send that video to YouTube, but You can change the server URL to stream to other services like Facebook Live or Twitch.

Do not forget to change the **KEY** with your own information. There are other variables you should know defined in the file **stream.sh** and then, run that using the command **./stream.sh**. You can modify the file **marquee.txt** to change the marquee text in the stream.

```bash
sudo ./stream.sh
```

<!--## YouTube livestream test

[![YouTube ended LiveStream test](https://img.youtube.com/vi/YBMZCERdZpk/0.jpg)](https://www.youtube.com/watch?v=YBMZCERdZpk "YouTube ended LiveStream test")

## Demo files

* **video.mp4** [Motion Places - Free Stock Video](https://www.pexels.com/@motion-places-free-stock-video-701499)
-->
