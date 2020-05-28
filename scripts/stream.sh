#!/bin/sh

# Script to stream a video file at 720p to Twitch, via FFMPEg.
#
# * Bias to higher audio quality
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
       -vcodec libx264 -profile:v main -preset:v medium -r 30 -g 60 -keyint_min 60 -sc_threshold 0 \
       -b:v 2500k -maxrate 2500k -bufsize 2500k \
       -filter:v scale="trunc(oh*a/2)*2:720" \
       -sws_flags lanczos+accurate_rnd \
       -acodec aac -b:a 192k -ar 48000 -ac 2 -f flv rtmp://live.twitch.tv/app/$2
