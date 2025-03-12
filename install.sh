#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail -o noclobber

# Exit Codes:
#   0  success
#   1  getopt not supported
#   2  invalid or unrecognized arguments
#   3  link failure

#
# Global Options
#

dry_run=1

#
# Functions
#

link_file() {
	local src="$1"
	local dest="$2"

	if [[ -L "$dest" ]] && [[ "$(readlink -f "$src")" = "$(readlink -f "$dest")" ]]; then
		if [[ $dry_run -gt 0 ]]; then
			echo "  $src -> $dest"
		fi
	elif [[ ! -e "$dest" ]]; then
		if [[ $dry_run -gt 0 ]]; then
			echo "+ $src -> $dest"
		else
			mkdir -p "$(dirname "$dest")"
			ln -s "$src" "$dest"
		fi
	else
		if [[ $dry_run -gt 0 ]]; then
			echo "! $src -> $dest"
		else
			echo "failed to link '$src' to '$dest': file exists" >&2
			return 3
		fi
	fi
}

link_directory() {
	local src="$1"
	local dest="$2"
	shift 2
	local exclusions=("$@")

	local filename

	for file in "$src"/* "$src"/.*; do
		# ignore unexpanded pattern when no matches are found
		if [[ ! -e "$file" ]]; then continue; fi

		# ignore excluded files
		filename="$(basename "$file")"
		for exclusion in "${exclusions[@]}"; do
			if [[ "$filename" = "$exclusion" ]]; then continue 2; fi
		done

		link_file "$file" "$dest/$filename"
	done
}

usage() {
	echo "Usage: $0 [-h|--help] [-a|--apply]" >&2
}

#
# Main
#

# verify that enhanced getopt is available
getopt --test >/dev/null && true
if [[ $? -ne 4 ]]; then
	echo "getopt failure" >&2
	exit 1
fi

# parse arguments
PARSED=$(getopt \
	--name "$0" \
	--longoptions="help,apply" \
	--options="ha" \
	-- "$@") || exit 2
eval set -- "$PARSED"

while true; do
	case "$1" in
	-a | --apply)
		dry_run=0
		shift
		;;
	-h | --help)
		usage
		exit 0
		;;
	--)
		shift
		break
		;;
	*)
		usage
		exit 2
		;;
	esac
done

# link dotfiles
DOTFILES_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

link_directory "$DOTFILES_DIR/home" "$HOME" ".config"
link_directory "$DOTFILES_DIR/home/.config" "$HOME/.config"
