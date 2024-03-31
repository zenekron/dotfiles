#!/usr/bin/env sh
cd "$HOME/.dotfiles/src" || exit
exec python -m "dotfiles" "$@"
