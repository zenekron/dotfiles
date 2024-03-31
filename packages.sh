#!/usr/bin/env sh
cd "./src" || exit
exec python -m "packages" "$@"
