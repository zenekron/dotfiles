#!/usr/bin/env bash
set -eu -o pipefail

wallpaper=$(find ~/.dotfiles/wallpapers -type f | fzf)
hyprctl hyprpaper preload "$wallpaper" >/dev/null 2>&1
hyprctl hyprpaper wallpaper ", $wallpaper" >/dev/null 2>&1
