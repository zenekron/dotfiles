#!/usr/bin/env zsh
# Used for setting user's environment variables; it should not contain commands
# that produce output or assume the shell is attached to a TTY. When this file
# exists it will always be read.

typeset -U path # https://zsh.sourceforge.io/Guide/zshguide02.html#l24

#======================================================================
# xdg user directories
# https://wiki.archlinux.org/title/XDG_Base_Directory
#======================================================================

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/state"
export XDG_STATE_HOME="$HOME/.local/state"

# `XDG_RUNTIME_DIR` is set by `pam`



#======================================================================
# zsh
#======================================================================

# history
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTSIZE="1000"
export SAVEHIST="$HISTSIZE"
mkdir -p ${HISTFILE:h}



#======================================================================
# default programs
# https://wiki.archlinux.org/title/Environment_variables
#======================================================================

# SHELL is usually set by the running shell

export PAGER="less -RF"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"

# man - https://github.com/sharkdp/bat#man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"



#======================================================================
# misc
#======================================================================

path+=(~/.dotfiles/bin)

# kubectl
export KUBECONFIG="$XDG_CONFIG_HOME/kubectl/config.yaml"

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
path+=($PNPM_HOME)

# rust
export RUSTC_WRAPPER="sccache"
path+=($HOME/.cargo/bin) # `cargo-install`-ed software

# ssh
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
