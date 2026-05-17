#!/bin/bash
# Generate VSL audio using OpenAI TTS with American voice

API_KEY="$(grep OPENAI_API_KEY ~/.openclaw/workspace/.env.personal | cut -d= -f2)"

# Script broken into chunks (OpenAI has limits)
SCRIPT_PART1="When was the last time you truly exhaled? Not the quick breath between meetings. Not the sigh at the end of a long day. I mean a real exhale. The kind that comes from your whole body. The kind that says: I am safe now. I can rest."

SCRIPT_PART2="You have been holding your breath for years. Between the career demands, the family needs, the endless to-do list. You have been running on empty for so long that you have forgotten what full feels like."

SCRIPT_PART3="You want to travel. You crave adventure, beauty, new experiences. But the thought of planning it all? That is another job you do not have time for. And going alone? That feels scary. What if you are lonely? What if something goes wrong?"

SCRIPT_PART4="So you keep waiting. Keep holding your breath. Keep telling yourself someday. What if you did not have to plan a thing? What if you could just show up and everything was handled?"

SCRIPT_PART5="The Exhale Retreat is a six-day curated healing journey for women exactly like you. Women who are ready to travel solo but want the safety of a small group. We handle everything. You just arrive. And exhale."

SCRIPT_PART6="Picture this. Day one, you are greeted by women who understand. No forced icebreakers, just organic connection. Day two, you wake up to rolling hills and wide skies. You move your body gently. You sit in silence. You remember what your own breath feels like."

SCRIPT_PART7="By day four, something shifts. The tension you have carried for years starts to loosen. You laugh more easily. You sleep more deeply. You start to remember who you are underneath all the roles you play."

SCRIPT_PART8="And by day six, you leave grounded. Clear. More connected to yourself than you have been in years. The Exhale Retreat is thirty-five hundred dollars, all-inclusive. Six days, five nights, everything handled."

SCRIPT_PART9="A five hundred dollar deposit reserves your spot. The balance is not due until thirty days before we gather. And if life happens and you need to cancel? You have thirty days to change your mind with a full refund."

SCRIPT_PART10="You do not need to fix your life. You need space to breathe. The Exhale Retreat is that space. Click the button below. Reserve your spot. And finally, finally, exhale."

# Generate each part
echo "Generating part 1..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART1\"}" \
  --output tts-part1.mp3

echo "Generating part 2..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART2\"}" \
  --output tts-part2.mp3

echo "Generating part 3..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART3\"}" \
  --output tts-part3.mp3

echo "Generating part 4..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART4\"}" \
  --output tts-part4.mp3

echo "Generating part 5..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART5\"}" \
  --output tts-part5.mp3

echo "Generating part 6..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART6\"}" \
  --output tts-part6.mp3

echo "Generating part 7..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART7\"}" \
  --output tts-part7.mp3

echo "Generating part 8..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART8\"}" \
  --output tts-part8.mp3

echo "Generating part 9..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART9\"}" \
  --output tts-part9.mp3

echo "Generating part 10..."
curl -s https://api.openai.com/v1/audio/speech \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"tts-1\", \"voice\": \"nova\", \"input\": \"$SCRIPT_PART10\"}" \
  --output tts-part10.mp3

# Combine all parts
echo "Combining audio files..."
ffmpeg -y -i "concat:tts-part1.mp3|tts-part2.mp3|tts-part3.mp3|tts-part4.mp3|tts-part5.mp3|tts-part6.mp3|tts-part7.mp3|tts-part8.mp3|tts-part9.mp3|tts-part10.mp3" -acodec copy vsl-audio-american.mp3

echo "Done! Audio saved to vsl-audio-american.mp3"
ls -la vsl-audio-american.mp3