#!/bin/bash

case "$1" in
  on)
    hyprctl keyword monitor "eDP-1,2944x1840@90.00Hz,3840x0,2"
    brightnessctl --device='platform::kbd_backlight' set 1
    ;;
  off)
    hyprctl keyword monitor "eDP-1,disabled"
    brightnessctl --device='platform::kbd_backlight' set 0
    ;;
  *)
    echo "Usage: $(basename "$0") {on|off}" >&2
    exit 1
    ;;
esac
