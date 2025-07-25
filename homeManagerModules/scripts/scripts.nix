{ pkgs, ... }:

let
  em = pkgs.writeShellScriptBin "em" ''
    emacsclient -c -a 'emacs --init-directory ~/.dotfiles/emacs'
  '';
  push-dotfiles = pkgs.writeShellScriptBin "push-dotfiles" ''
    set -e
    pushd ~/.dotfiles/
    
    git diff -U0 *.nix
    echo "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake .#default &>nixos-switch.log || (
      cat nixos-switch.log | grep --color error && false
    )
    gen=$(nixos-rebuild list-generations | grep current)
    git commit -am "$gen"
    popd
  '';
  track-add = pkgs.writeShellScriptBin "track-add" ''
    set -euo pipefail
    
    if [ -z "$\{1-}" ]; then
      echo "Usage: $0 <YouTube-URL>"
      exit 1
    fi
    
    URL="$1"
    OUTDIR="$HOME/Music"  # Change this if you want
    TMPDIR="$(mktemp -d)"
    
    # 1. Download and convert to MP3
    yt-dlp --no-playlist \
           -x --audio-format mp3 \
           -o "$TMPDIR/%(title).200s.%(ext)s" \
           "$URL"
    
    # 2. Prompt for metadata
    read -rp "Enter Artist: " ARTIST
    read -rp "Enter Title: " TITLE
    
    # 3. Tag with eyeD3
    MP3_FILE="$(find "$TMPDIR" -type f -name '*.mp3' | head -n 1)"
    eyeD3 --artist="$ARTIST" --title="$TITLE" "$MP3_FILE"
    
    # 4. Move to final destination
    mv "$MP3_FILE" "$OUTDIR/"
    
    # 5. Cleanup
    rm -rf "$TMPDIR"
    
    echo "✔ Downloaded, tagged, and saved to $OUTDIR"
  '';
  cycle-wallpapers = pkgs.writeShellScriptBin "cycle-wallpapers" ''
    wallpapersDir="$HOME/.dotfiles/wallpapers"
    
    # Get a list of all image files in the wallpapers directory
    wallpapers=("$wallpapersDir"/*)
    
    # Start an infinite loop
    while true; do
        # Check if the wallpapers array is empty
        if [ $\{#wallpapers[@]} -eq 0 ]; then
            # If the array is empty, refill it with the image files
            wallpapers=("$wallpapersDir"/*)
        fi
    
        # Select a random wallpaper from the array
        wallpaperIndex=$(( RANDOM % $\{#wallpapers[@]} ))
        selectedWallpaper="$\{wallpapers[$wallpaperIndex]}"
    
        # Update the wallpaper using the swww img command
        swww img "$selectedWallpaper" -t right --transition-fps 60
    
        # Remove the selected wallpaper from the array
        unset "wallpapers[$wallpaperIndex]"
    
        # Delay before selecting the next wallpaper
        sleep 1h
    done
  '';
in
{
  home.packages = [ em push-dotfiles track-add cycle-wallpapers ];
}
