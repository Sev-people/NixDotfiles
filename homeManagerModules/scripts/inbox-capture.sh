# Only works when Emacs daemon is running
if ! pgrep -x emacs >/dev/null; then
  exit 0
fi

MARK="emacs-capture-$(date +%s%N)"

emacsclient -c --eval "(org-capture nil \"i\")" --frame-parameters="((name . \"$MARK\"))" &

# Check for existence of window
for i in $(seq 1 10); do
  if swaymsg -t get_tree -r | jq -e ".. | objects | select(.instance? == \"$MARK\")" > /dev/null; then
    break
  else
    sleep 0.1
  fi
done

swaymsg \[instance=$MARK\] floating enable, move position center, focus

exit 0
