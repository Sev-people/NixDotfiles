#!/bin/bash

# Set the path to the wallpapers directory
wallpapersDir="$HOME/.dotfiles/wallpapers"

# Get a list of all image files in the wallpapers directory
wallpapers=("$wallpapersDir"/*)

# Start an infinite loop
while true; do
    # Check if the wallpapers array is empty
    if [ ${#wallpapers[@]} -eq 0 ]; then
        # If the array is empty, refill it with the image files
        wallpapers=("$wallpapersDir"/*)
    fi

    # Select a random wallpaper from the array
    wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
    selectedWallpaper="${wallpapers[$wallpaperIndex]}"

    # Update the wallpaper using the swww img command
    swww img "$selectedWallpaper" -t right --transition-fps 60

    # Remove the selected wallpaper from the array
    unset "wallpapers[$wallpaperIndex]"

    # Delay for 2 hours before selecting the next wallpaper
    sleep 1h
done