#!/usr/bin/env sh

export WLR_NO_HARDWARE_CURSORS=1 # fixes terrible VM performance at the cost of a slightly slower cursor on metal

# https://wiki.archlinux.org/title/Wayland#GUI_libraries
export GDK_BACKEND="wayland,x11"
export QT_QPA_PLATFORM="wayland;xcb"
export CLUTTER_BACKEND="wayland"
export SDL_VIDEODRIVER="wayland,x11"
export ELECTRON_OZONE_PLATFORM_HINT="auto"
export _JAVA_AWT_WM_NONREPARENTING=1 # fixes misbehavior where the application starts with a blank screen

exec "$@"
