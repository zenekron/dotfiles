# https://wiki.archlinux.org/title/XDG_Base_Directory
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"

# update path
fish_add_path "$HOME/.dotfiles/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
