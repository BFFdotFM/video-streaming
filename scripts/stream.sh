#!/bin/sh

# Script to stream a video file at 720p to Twitch, via FFMPEg.
#
# * Bias to higher audio quality
#
# Usage:
#
# ./stream.sh filename.mp4 twitch-stream-id [timestamp]
#
# Timestamp defaults to 00:00:00 (start from beginning of the file), can be entered if you need to
# restart a stream recording that crashes mid-way through

# Support starting at a specific timestamp must be of form HH:MM:SS
if [ -n "$3" ]
then
  ts=$3
else
  ts="0:00:00"
fi

ffmpeg -ss $ts \
       -re -i $1 \
# Include audio coded as-per encode.sh, else ffmpeg defaults to transcoding it to MP3
       -acodec aac -b:a 192k -ar 44100 -ac 2 \
# Twitch
#       -f flv rtmp://live.twitch.tv/app/$2 \
# YouTube Live
#       -f flv rtmp://a.rtmp.youtube.com/live2/$2
