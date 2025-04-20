# https://wiki.archlinux.org/title/XDG_Base_Directory
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"

# https://github.com/direnv/direnv
if type -q direnv; direnv hook fish | source; end
# https://github.com/starship/starship
if type -q starship; starship init fish | source; end

# update path
fish_add_path "$HOME/.dotfiles/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status is-login
	if test -z "$WAYLAND_DISPLAY" -a $XDG_VTNR -eq 1
		exec wayland-run.sh sway
		# exec wayland-run.sh Hyprland
	end
end
