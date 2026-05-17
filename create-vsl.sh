#!/bin/bash

# Create VSL video with audio and images using ffmpeg

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg not found. Installing..."
    apt-get update && apt-get install -y ffmpeg
fi

# Create a simple video with the audio and cycling images
ffmpeg -y \
    -loop 1 -i images/black-woman-forest.jpg \
    -loop 1 -i images/hill-country-1.jpg \
    -loop 1 -i images/diverse-hikers.jpg \
    -loop 1 -i images/asian-women-mountain.jpg \
    -loop 1 -i images/woman-hiking-1.jpg \
    -i vsl-audio.mp3 \
    -filter_complex "
        [0:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fade=out:st=30:d=1[v0];
        [1:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fade=in:st=0:d=1,fade=out:st=30:d=1[v1];
        [2:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fade=in:st=0:d=1,fade=out:st=30:d=1[v2];
        [3:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fade=in:st=0:d=1,fade=out:st=30:d=1[v3];
        [4:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fade=in:st=0:d=1,fade=out:st=30:d=1[v4];
        [v0][v1][v2][v3][v4]concat=n=5:v=1:a=0[outv]
    " \
    -map "[outv]" -map 5:a \
    -c:v libx264 -preset fast -crf 23 \
    -c:a aac -b:a 192k \
    -shortest \
    -movflags +faststart \
    vsl-video.mp4

echo "VSL video created: vsl-video.mp4"
