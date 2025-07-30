#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
    echo "Usage: $0 <YouTube-URL>"
    exit 1
fi

URL="$1"
OUTDIR="$HOME/Music"
TMPDIR="$(mktemp -d)"

# 1. Download best audio (Opus/WebM native)
yt-dlp --no-playlist \
       -f bestaudio \
       -o "$TMPDIR/%(title).200s.%(ext)s" \
       "$URL"

# 2. Identify downloaded file
DL_FILE="$(find "$TMPDIR" -type f | head -n 1)"
BASENAME="$(basename "${DL_FILE%.*}")"

# 3. Re-containerize to Opus (.opus), preserving audio
OPUS_FILE="$TMPDIR/${BASENAME}.opus"
ffmpeg -i "$DL_FILE" -c:a copy "$OPUS_FILE" -loglevel error
rm "$DL_FILE"

# 4. Prompt for metadata
read -rp "Enter Artist: " ARTIST
read -rp "Enter Title: " TITLE

# 5. Tag using ffmpeg (remux)
TAGGED_FILE="$TMPDIR/${BASENAME}_tagged.opus"
ffmpeg -i "$OPUS_FILE" -c:a copy \
    -metadata artist="$ARTIST" \
    -metadata title="$TITLE" \
    "$TAGGED_FILE" -loglevel error

# 6. Move tagged file to library
mv "$TAGGED_FILE" "$OUTDIR/${BASENAME}.opus"
rm -rf "$TMPDIR"

echo "✔ Saved and tagged: $OUTDIR/${BASENAME}.opus"
