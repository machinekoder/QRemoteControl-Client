#!/bin/bash
#
# (Batch) SVG to PNG script.
# Converts an svg file into a number of png files of different sizes.
# The sizes can be specified in the sizes array (line 15).
#
# Potential issues:
#   This script will overwrite existing png files
# Parameters:
#   at least one path of SVG file to convert
# Requires:
#   rsvg (http://librsvg.sourceforge.net/)
# Author:
#   Konrad Siek 

# Array of sizes to convert to
sizes=(16 32 64 80 92 114 128 256 480 512)

# Check if any files were specified
if [ $# -gt 0 ]; then
    for svg_file in $@
    do
        # Check if file exists
        if [ -f $svg_file ]
        then
            # Extract name of file (remove extension)
            svg_name=$(echo $svg_file | cut -f 1 -d "." | tr -d " ")
    
            # Convert file to png with of the sizes
            for s in $(seq 0 $((${#sizes[@]} - 1)))
            do
                size=${sizes[$s]}
                rsvg-convert -w $size -h $size $svg_file -o $svg_name$size.png
            done
        else
            # Warning message.
            echo "$0: File $svg_file does not exist and will be ignored."
        fi
    done
else
    # Usage message.
    echo "$0: Provide at least one SVG file to convert, please."
fi 
