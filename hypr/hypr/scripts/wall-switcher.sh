#!/bin/bash

# Time interval in seconds (5 minutes)
TIMEOUT=300

# Directory where wallpapers are stored
WALL_DIR="$HOME/.config/wall/"

# Ensure swww is installed
command -v swww >/dev/null 2>&1 || {
    notify-send "swww not found"
    exit 1
}

# Kill previous instance of this script, except current
for pid in $(pidof -o %PPID -x wall-switcher.sh); do
    kill "$pid"
done

# Check if wallpaper directory exists and has at least 1 file
if [ ! -d "$WALL_DIR" ]; then
    notify-send -t 5000 "Wallpaper directory does not exist: $WALL_DIR"
    exit 1
fi

WALL_COUNT=$(find "$WALL_DIR" -type f | wc -l)
if [ "$WALL_COUNT" -lt 1 ]; then
    notify-send -t 9000 "The wallpaper folder must contain at least one image."
    exit 1
fi

# Track previous wallpaper to avoid repetition
PREVIOUS=""

while true; do
    # Randomly pick a wallpaper, ensuring it's different from the previous one
    while true; do
        WALLPAPER=$(find "$WALL_DIR" -type f | shuf -n 1)
        [ "$WALLPAPER" != "$PREVIOUS" ] && break
    done

    PREVIOUS="$WALLPAPER"
    echo "Setting wallpaper to $WALLPAPER"

    # Start swww daemon if not already running
    swww query || swww init

    # Set wallpaper with a transition
    swww img "$WALLPAPER" --transition-type any --transition-fps 60

    # Notify the user
    notify-send -t 3000 "Wallpaper changed" "$(basename "$WALLPAPER")"

    sleep "$TIMEOUT"
done
