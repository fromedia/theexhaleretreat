#!/usr/bin/env python3
"""
VSL Audio Generator for The Exhale Retreat
Uses ElevenLabs API with American voice
"""

import os
import requests

# ElevenLabs API
ELEVENLABS_API_KEY = os.getenv("ELEVENLABS_API_KEY")

# American voice IDs (no British accent)
# Rachel - American female, mature, warm
# Adam - American male, natural
# Nicole - American female, soft
VOICE_ID = "Rachel"  # American female voice

# The script
SCRIPT = """When was the last time you truly exhaled?

Not the quick breath between meetings.
Not the sigh at the end of a long day.

I mean a real exhale.
The kind that comes from your whole body.
The kind that says: I'm safe now. I can rest.

You've been holding your breath for years.

Between the career demands, the family needs, the endless to-do list—you've been running on empty for so long that you've forgotten what full feels like.

You want to travel. You crave adventure, beauty, new experiences. But the thought of planning it all? That's another job you don't have time for.

And going alone? That feels scary. What if you're lonely? What if something goes wrong? What if you spend all this money and don't get what you need?

So you keep waiting. Keep holding your breath. Keep telling yourself someday.

What if you didn't have to plan a thing?

What if you could just show up—and everything was handled?

The Exhale Retreat is a six-day curated healing journey for women exactly like you. Women who are ready to travel solo but want the safety of a small group. Women who need space to breathe but don't have time to coordinate logistics.

We handle everything. Your beautiful accommodation in the Texas Hill Country. All your meals—nourishing, delicious, no decisions required. Ground transportation. Curated excursions. Daily healing sessions.

You just arrive. And exhale.

Picture this:

Day one, you're greeted by women who understand. No forced icebreakers—just organic connection over a beautiful dinner.

Day two, you wake up to rolling hills and wide skies. You move your body gently. You sit in silence. You remember what your own breath feels like.

By day four, something shifts. The tension you've carried for years starts to loosen. You laugh more easily. You sleep more deeply. You start to remember who you are underneath all the roles you play.

And by day six, you leave grounded. Clear. More connected to yourself than you've been in years.

The Exhale Retreat is thirty-five hundred dollars—all-inclusive. Six days, five nights, everything handled.

A five hundred dollar deposit reserves your spot. The balance isn't due until thirty days before we gather.

And if life happens and you need to cancel? You have thirty days to change your mind with a full refund.

You don't need to fix your life. You need space to breathe.

The Exhale Retreat is that space.

Click the button below. Reserve your spot. And finally—finally—exhale."""

def generate_audio():
    """Generate audio using ElevenLabs API"""
    url = f"https://api.elevenlabs.io/v1/text-to-speech/{VOICE_ID}"
    
    headers = {
        "Accept": "audio/mpeg",
        "Content-Type": "application/json",
        "xi-api-key": ELEVENLABS_API_KEY
    }
    
    data = {
        "text": SCRIPT,
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {
            "stability": 0.5,
            "similarity_boost": 0.5
        }
    }
    
    print(f"Generating audio with voice: {VOICE_ID}...")
    response = requests.post(url, json=data, headers=headers)
    
    if response.status_code == 200:
        with open("vsl-audio-american.mp3", "wb") as f:
            f.write(response.content)
        print("Audio saved to vsl-audio-american.mp3")
        return True
    else:
        print(f"Error: {response.status_code}")
        print(response.text)
        return False

if __name__ == "__main__":
    if not ELEVENLABS_API_KEY:
        print("Error: ELEVENLABS_API_KEY not set")
        exit(1)
    
    generate_audio()
