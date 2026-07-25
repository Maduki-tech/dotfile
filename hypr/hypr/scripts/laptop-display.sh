#!/bin/bash
# Lid-switch handler.
# Clamshell mode only: the internal panel is disabled on lid close ONLY when
# an external monitor is connected (logind ignores the lid then, no suspend).
# With no external monitor the panel must stay enabled, because logind
# suspends the machine — disabling it left Hyprland with zero monitors and a
# black screen on wake.

INTERNAL="eDP-1"

external_connected() {
  hyprctl monitors -j | jq -e --arg int "$INTERNAL" \
    'map(select(.name != $int and (.disabled | not))) | length > 0' >/dev/null
}

case "$1" in
  on)
    hyprctl keyword monitor "$INTERNAL,2944x1840@90.00Hz,3840x0,2"
    brightnessctl --device='platform::kbd_backlight' set 1
    ;;
  off)
    if external_connected; then
      hyprctl keyword monitor "$INTERNAL,disabled"
      brightnessctl --device='platform::kbd_backlight' set 0
    fi
    ;;
  *)
    echo "Usage: $(basename "$0") {on|off}" >&2
    exit 1
    ;;
esac
