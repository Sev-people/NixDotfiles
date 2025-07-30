#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
  echo "Usage: $0 <YouTube-URL>"
  exit 1
fi

URL="$1"
OUTDIR="$HOME/Music"  # Change this if desired
TMPDIR="$(mktemp -d)"

# 1. Download best audio (Opus/WebM native from YouTube)
yt-dlp --no-playlist \
       -f bestaudio \
       -o "$TMPDIR/%(title).200s.%(ext)s" \
       "$URL"

# 2. Locate the downloaded file
DL_FILE="$(find "$TMPDIR" -type f | head -n 1)"
BASENAME="$(basename "${DL_FILE%.*}")"

# 3. Re-containerize WebM → Opus (near-instant, no re-encode)
OPUS_FILE="$TMPDIR/${BASENAME}.opus"
ffmpeg -i "$DL_FILE" -c:a copy "$OPUS_FILE" -loglevel error
rm "$DL_FILE"

# 4. Prompt for metadata
read -rp "Enter Artist: " ARTIST
read -rp "Enter Title: " TITLE
read -rp "Enter Album (optional): " ALBUM

# 5. Tag using opuscomment (instant)
opuscomment -w \
  --artist="$ARTIST" \
  --title="$TITLE" \
  ${ALBUM:+--album="$ALBUM"} \
  "$OPUS_FILE"

# 6. Move to final destination
FINAL="$OUTDIR/${BASENAME}.opus"
mv "$OPUS_FILE" "$FINAL"

# 7. Clean up
rm -rf "$TMPDIR"

echo "✔ Saved and tagged: $FINAL"
