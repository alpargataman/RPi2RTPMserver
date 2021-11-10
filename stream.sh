#! /bin/bash
# Configuration of ffmpeg

VBR="1000k"                                    # Video bitrate (480p -> 1000k, 720p -> 3000k)
FPS="24"                                       # Video FPS up to 30
QUAL="ultrafast"                               # FFMPEG preset quality
RESOLUTION="848x480"                           # Video resolution (848x480, 1280x720)

RTMP_URL="rtmp://a.rtmp.youtube.com/live2"     # RTMP server URL
KEY="xxxx-xxxx-xxxx-xxxx"                      # Stream key

VIDEO="video.mp4"                              # Video path

# Use parentheses to use Structural SImilarity Metric
# more info at https://ffmpeg.org/ffmpeg-all.html#ssim
# ex_image: y=(100)
# ex_text: x=(250)

IMAGE="image.png"         # Cover path
IMAGE_X="50"              # X position of cover
IMAGE_Y="(100)"           # Y position of cover

TEXT="livetext.txt"       # Path to the TXT where the song data is
TEXT_X="(350)"            # X position of the song data
TEXT_Y="200"              # Y position of the song data

MARQUEE="marquee.txt"     # Path to the TXT with a marquee text
MARQUEE_Y="0.1"           # Y position of the marquee text (0.01 - 0.9)

FONT="FreeSerif.ttf"      # Path to the font
FONT_SIZE="20"            # Font size

THREADS="4"               # Number of threads used to encode video and audio
THREAD_QUEUE="2048"       # Thread queue size for audio
CRF="20"                  # Constant rate factor of the video

# Infinite loop
while [ 1 ]
do
    # change pulse for alsa is you are using it (Not recommended)
    ffmpeg \
    -stream_loop -1 -i $VIDEO \
    -thread_queue_size $THREAD_QUEUE -f pulse -i default \
    -f lavfi -re -i anullsrc \
    -f image2 -stream_loop -1 -r 2 -i $IMAGE \
    -filter_complex \
    "[1:a][2:a] amix=inputs=2,volume=2.5 [audiooutput]; \
     [0:v] overlay=x=$IMAGE_X:y=$IMAGE_Y,fps=fps=$FPS,scale=$RESOLUTION [inputvideo]; \
     [inputvideo] \
       drawtext=textfile=$MARQUEE:fontfile=$FONT:fontsize=(w * 0.03333333333333333):bordercolor=#000000:borderw=1:fontcolor=#FFFFFF:reload=1:y=(h * $MARQUEE_Y):x=w-mod(max(t\, 0) * (w + tw) / 20\, (w + tw)), \
       drawtext=textfile=$TEXT:fontfile=$FONT:fontsize=(w * 0.03333333333333333):bordercolor=#000000:borderw=1:fontcolor=#FFFFFF:reload=1:y=(h-text_h-$TEXT_Y):x=$TEXT_X \
    [videooutput]" \
    -acodec copy -acodec copy \
    -map [videooutput] -map [audiooutput] \
    -r $FPS -g $(($FPS*2)) \
    -pix_fmt yuv420p -x264-params keyint=$(($FPS*2)):min-keyint=$(($FPS*2)):scenecut=-1 \
    -s $RESOLUTION -b:v $VBR -b:a 128k -ar 44100 -acodec aac \
    -vcodec libx264 -preset $QUAL -bufsize $VBR -crf $CRF -threads $THREADS \
    -f flv "$RTMP_URL/$KEY"
    
done
