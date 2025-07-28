INTERVAL=2

while true; do
  # Time and date
  datetime=$(date "+%a %d %b %Y %H:%M")

  # Battery (only if present)
  battery_status=""
  if [ -d /sys/class/power_supply/BAT0 ]; then
    bat_level=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    bat_stat=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
    battery_status="Charge: $bat_level% ($bat_stat)"
  fi

  # Network info
  ssid=$(iwgetid -r 2>/dev/null || echo "No SSID")
  signal=$(awk 'NR==3 {print int($3 * 100 / 70)}' /proc/net/wireless 2>/dev/null || echo "N/A")
  network="Signal: $signal%"

  # Volume
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -o '[0-9]\+%' | head -1 || echo "Muted")
  vol_status="$volume volume"

  # Combine
  output="$vol_status | $network"
  [ -n "$battery_status" ] && output="$output | $battery_status"
  output="$output | $datetime"

  echo "$output"
  sleep $INTERVAL
done
