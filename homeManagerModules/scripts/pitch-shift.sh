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

sleep 1  # Allow PipeWire to register nodes

# Pitch shift pipeline (correct formats, silence banner)
pw-record --target "$TMP_CAPTURE" --channels 2 --rate 48000 --format f32 - \
    | rubberband -R -p "$SEMITONES" -f -q --stdin --stdout 2>/dev/null \
    | pw-play --target "$TMP_PLAYBACK" --channels 2 --rate 48000 --format f32 -

RB_PID=$!

echo "Pitch shifted by $SEMITONES semitones. Press Ctrl+C to stop."

trap 'kill $RB_PID $LOOP_PID; echo "Stopped."; exit 0' INT TERM
wait
