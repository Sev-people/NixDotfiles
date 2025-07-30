set -euo pipefail

if [ -z "${1-}" ]; then
    echo "Usage: $0 <semitones>"
    exit 1
fi

SEMITONES="$1"

# Launch PipeWire pitch shift filter node
NODE_ID=$(pw-loopback --capture-props='node.name=PitchCapture' \
                      --playback-props='node.name=PitchOutput' \
                      --filter='pitch' \
                      --filter.params="semishift=$SEMITONES" & echo $!)

echo "Pitch shifted by $SEMITONES semitone(s). Press Ctrl+C or close terminal to stop."

# Cleanup: trap SIGINT/SIGTERM and nuke the loopback node automatically
cleanup() {
    echo "Stopping pitch shift..."
    kill "$NODE_ID" 2>/dev/null || true
    # In case something stubborn lingers, force-remove any pitch filter nodes
    pw-cli ls Node | grep -B1 'PitchCapture\|PitchOutput' | grep 'id' | awk '{print $2}' | while read -r id; do
        pw-cli destroy "$id" || true
    done
    exit 0
}

trap cleanup INT TERM EXIT

# Wait on child so it dies with terminal
wait "$NODE_ID"
