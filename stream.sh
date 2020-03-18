#! /bin/bash
# Configuration of ffmpeg

VBR="3000k"                                    # Video bitrate
FPS="30"                                       # Video FPS
QUAL="ultrafast"                               # FFMPEG preset quality
RESOLUTION="848x480"                           # Video resolution
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # RTMP server URL
VIDEO="video.mp4"                              # Video path
IMAGE="image.png"                              # Cover path
TEXT="livetext.txt"                            # Path to the TXT where the song data is
MARQUEE="marquee.txt"                          # Path to the TXT with a marquee text
FONT="FreeSerif.ttf"                           # Path to the font
FONT_SIZE="20"                                 # Font size 
THREADS="4"                                    # Number of threadsusing to encode video and audio
THREAD_QUEUE="2048"                            # Thread queue size for audio
CRF="20"                                       # Constant rate factor of the video
KEY="xxxx-xxxx-xxxx-xxxx"                      # Stream key 

# infinite loop
while [ 1 ]
do
ffmpeg \
  -stream_loop -1 -i $VIDEO \
  -thread_queue_size $THREAD_QUEUE -f pulse -i default \
  -f lavfi -re -i anullsrc \
  -f image2 -stream_loop -1 -r 2 -i $IMAGE \
  -filter_complex \
    "[1:a][2:a] amix=inputs=2,volume=2.5 [audiooutput]; \
     [0:v] overlay=x=25:y=(250),fps=fps=$FPS,scale=$RESOLUTION [inputvideo]; \
     [inputvideo] \
       drawtext=textfile=$MARQUEE:fontfile=$FONT:fontsize=(w * 0.03333333333333333):bordercolor=#000000:borderw=1:fontcolor=#FFFFFF:reload=1:y=(h * 0.05):x=w-mod(max(t\, 0) * (w + tw) / 20\, (w + tw)), \
       drawtext=textfile=$TEXT:fontfile=$FONT:fontsize=(w * 0.03333333333333333):bordercolor=#000000:borderw=1:fontcolor=#FFFFFF:reload=1:y=(h-text_h-25):x=(170) \
     [videooutput]" \
  -acodec copy -acodec copy \
  -map [videooutput] -map [audiooutput] \
  -r $FPS -g $(($FPS*2)) \
  -pix_fmt yuv420p -x264-params keyint=$(($FPS*2)):min-keyint=$(($FPS*2)):scenecut=-1 \
  -s $RESOLUTION -b:v $VBR -b:a 128k -ar 44100 -acodec aac \
  -vcodec libx264 -preset $QUAL -bufsize $VBR -crf $CRF -threads $THREADS \
  -f flv "$YOUTUBE_URL/$KEY" 
  
done

