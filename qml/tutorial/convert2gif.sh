#!/bin/sh
ffmpeg -i $1 -r 4  frame%3d.jpg
convert -delay 18 -loop 0 -depth 8 -colors 50 -type palette frame*.jpg animation.gif
rm frame*.jpg