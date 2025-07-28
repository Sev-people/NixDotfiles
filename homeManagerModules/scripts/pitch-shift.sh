set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <semitones>"
    exit 1
fi

SEMITONES=$1
TMP_CAPTURE="pitch_capture"
TMP_PLAYBACK="pitch_playback"

# Create loopback nodes
pw-loopback --capture-props="node.name=$TMP_CAPTURE media.class=Audio/Source/Virtual" \
            --playback-props="node.name=$TMP_PLAYBACK media.class=Audio/Sink" &
LOOP_PID=$!

# Wait for loopback nodes to appear
sleep 1

# Pipe audio: capture -> rubberband -> playback
pw-record --target "$TMP_CAPTURE" --channels 2 --format float32 --rate 48000 - \
    | rubberband -p "$SEMITONES" -R -t 1.0 - \
    | pw-play --target "$TMP_PLAYBACK" --channels 2 --format float32 --rate 48000 &

RB_PID=$!

echo "Pitch shifted by $SEMITONES semitones. Press Ctrl+C to stop."

trap 'kill $RB_PID $LOOP_PID; echo "Stopped pitch shift."; exit 0' INT TERM
wait
