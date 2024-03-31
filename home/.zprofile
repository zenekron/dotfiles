#!/usr/bin/env zsh
# Used for executing user's commands at start, will be read when starting as a
# login shell. Typically used to autostart graphical sessions and to set
# session-wide environment variables.

if [[ -z $WAYLAND_DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
	exec wayland-run.sh Hyprland
fi
