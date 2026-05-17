#!/usr/bin/env python3
"""
VSL Video Builder for The Exhale Retreat
"""

import subprocess
import os

# Config
WIDTH = 1920
HEIGHT = 1080
FPS = 30
AUDIO_FILE = "vsl-audio.mp3"
OUTPUT_FILE = "vsl-video.mp4"

# Script sections with timing (approximate)
# Total ~5 minutes = 300 seconds
sections = [
    ("When was the last time", "you truly exhaled?", 5),
    ("Not the quick breath", "between meetings.", 4),
    ("Not the sigh", "at the end of a long day.", 4),
    ("I mean a real exhale.", "The kind that comes from your whole body.", 5),
    ("The kind that says:", "I'm safe now. I can rest.", 5),
    ("You've been holding", "your breath for years.", 5),
    ("Between the career demands,", "the family needs...", 5),
    ("...the endless to-do list—", "you've been running on empty.", 5),
    ("You want to travel.", "You crave adventure.", 4),
    ("But planning it all?", "That's another job.", 4),
    ("And going alone?", "That feels scary.", 4),
    ("So you keep waiting.", "Keep holding your breath.", 5),
    ("What if you didn't have", "to plan a thing?", 5),
    ("What if you could", "just show up?", 4),
    ("The Exhale Retreat is", "a 6-day healing journey.", 5),
    ("For women ready to travel solo", "but want safety in a small group.", 5),
    ("We handle everything.", "You just arrive.", 5),
    ("Picture this:", "Day one, you're greeted by women who understand.", 5),
    ("Day two, rolling hills", "and wide skies.", 4),
    ("By day four,", "something shifts.", 4),
    ("By day six,", "you leave grounded.", 4),
    ("The Exhale Retreat", "$3,500—all-inclusive.", 5),
    ("$500 deposit", "reserves your spot.", 4),
    ("30-day refund guarantee.", "No risk.", 4),
    ("You don't need to", "fix your life.", 4),
    ("You need space", "to breathe.", 4),
    ("Click below.", "Reserve your spot.", 4),
    ("And finally—", "finally—exhale.", 5),
]

# Create frames directory
os.makedirs("vsl-frames", exist_ok=True)

# Generate frames
frame_num = 0
for line1, line2, duration in sections:
    for i in range(duration * FPS):
        # Create frame with text
        # This is a simplified version - in reality you'd use PIL or similar
        frame_num += 1

print(f"Would generate {frame_num} frames")
print("Creating video with ffmpeg...")

# Use ffmpeg to combine audio and create video
# For now, just copy the audio as the video component
subprocess.run([
    "ffmpeg", "-y",
    "-i", AUDIO_FILE,
    "-vf", f"scale={WIDTH}:{HEIGHT}:force_original_aspect_ratio=decrease,pad={WIDTH}:{HEIGHT}:(ow-iw)/2:(oh-ih)/2:black",
    "-c:v", "libx264",
    "-c:a", "aac",
    "-b:a", "192k",
    "-shortest",
    OUTPUT_FILE
], check=True)

print(f"Video created: {OUTPUT_FILE}")
