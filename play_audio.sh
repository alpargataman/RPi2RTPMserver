#!/bin/bash

FOLDER=mp3              # Folder with songs
COVER_SIZE="200"    	# Song cover size
INTERNET_COVER=0        # If cover doesn't exist download it form the internet [1|0]

while :
do
    echo "Deleting old cover "; rm "cover.png"
    
    echo "Lookig for next song in the folder"
    mapfile -t my_array < <(find $FOLDER -iname "*.mp3")
    
    echo "Choosing next song randomly"
    SONG=${my_array[ RANDOM % ${#my_array[@]}]}
    
    # Saving next song data in variables for later use
    ARTIST=$(exiftool "$SONG" | grep "Artist  " | cut -f2 -d':')
    ALBUM=$(exiftool "$SONG" | grep "Album  " | cut -f2 -d':')
    TITLE=$(exiftool "$SONG" | grep "Title  " | cut -f2 -d':')
    
    # Changing song info in the video
    echo $ARTIST > livetext.txt
    echo $ALBUM >> livetext.txt
    echo $TITLE >> livetext.txt
    
    echo "Playing  $SONG"
    # ffplay -nodisp -autoexit -af dynaudnorm $SONG &
    # cvlc --play-and-exit $SONG &
    
    # If you are using ALSA: -ao alsa:device=hw=1
    mplayer -af volnorm=2:0.05 "$SONG" &
    
    # Taking next song's cover from file
    # Remove -hide_banner -loglevel error if you want the whole ffmpeg feedback
    ffmpeg -hide_banner -loglevel error -i "$SONG" cover.jpg
    if [ -f "cover.jpg" ]; then
        convert cover.jpg -resize "$COVER_SIZEx$COVER_SIZE"\> cover.png
        rm cover.jpg
    fi
    
    # If next song don't have a cover we will look for it on the internet
    if [[ ! -f "cover.png" ]] && [[ $INTERNET_COVER -eq 1 ]]; then
        sacad "$ARTIST" "$ALBUM" "$COVER_SIZE" cover.png
    fi
    
    # default.png will be a file to use if we dont have any cover downloaded
    if [ ! -f "cover.png" ]; then
        cp default.png image.png
    else
        cp cover.png image.png
    fi
    
    # We wait until the song ends
    wait
    echo "\n$SONG finished"
    
done
