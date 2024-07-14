#!/usr/bin/env zsh
# Used for setting the interactive shell configuration and executing commands,
# will be read when starting an interactive shell.

#======================================================================
# plugins
#======================================================================

source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" # must be loaded after `zsh-syntax-highlighting`

source "/usr/share/nvm/init-nvm.sh"

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"



#======================================================================
# misc
#======================================================================

source "$XDG_CONFIG_HOME/zsh/aliases.zsh"



#======================================================================
# zsh
#======================================================================

# options - man zshoptions
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select # navigate completion with arrows

source "$HOME/.dotfiles/modules/b4b4r07/enhancd/init.sh" # enhancd wants to be sourced after `compinit`



#======================================================================
# keybinds
#======================================================================

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
