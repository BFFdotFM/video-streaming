#!/bin/sh

# Script to stream a video file to Twitch, YouTube and Facebook simultaneously. Presumes pre-encoded using ./encode.sh
#
# Usage:
#
# ./stream.sh filename.mp4 [timestamp] [twitchKey] [youtubeKey] [facebookKey]
#
# TODO: Source keys from environment variables, only include output streams for RTMPs where var is set
#
# Timestamp defaults to 00:00:00 (start from beginning of the file), can be entered if you need to
# restart a stream recording that crashes mid-way through

# Support starting at a specific timestamp must be of form HH:MM:SS
if [ -n "$2" ]
then
  ts=$2
else
  ts="0:00:00"
fi

ffmpeg -ss $ts \
       -re -i $1 \
       -c copy -f flv rtmp://sfo.contribute.live-video.net/app/$3 \
       -c copy -f flv rtmp://a.rtmp.youtube.com/live2/$4 \
       -c copy -f flv "rtmps://live-api-s.facebook.com:443/rtmp/$5"
