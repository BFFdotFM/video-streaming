#!/bin/sh

# Script to pre-encode a video file for live streaming, so that it doesn't get
# transcoded at live-time
#
# * Bias to higher audio quality
#
# Usage:
#
# ./encode.sh filename.mp4
#

ffmpeg -i $1 \
       -vcodec libx264 -profile:v main -preset:v medium -r 30 -g 60 -keyint_min 60 -sc_threshold 0 \
       -b:v 4500k -maxrate 4500k -bufsize 2500k \
       -filter:v scale="trunc(oh*a/2)*2:720" \
       -sws_flags lanczos+accurate_rnd \
       -acodec aac -b:a 192k -ar 44100 -ac 2 -f flv $1.flv
