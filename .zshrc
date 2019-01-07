# vim: ft=zsh sw=4 ts=4
#
# Debugging (You might want to turn these off)
# setopt SOURCE_TRACE
setopt WARN_CREATE_GLOBAL
setopt WARN_NESTED_VAR
setopt PRINT_EXIT_VALUE
setopt EVAL_LINENO

# Enable ZLE
setopt ZLE

# Enable vim-like line-editing
setopt VI

# Output hexadecimal in the standard C format of `0xFF` instead of `16#FF`
setopt C_BASES

# Notify when jobs finish
setopt NOTIFY

# Allow Multiple pipes, sounds like something we'd like
setopt MULTIOS                 

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS

# Completion behaviour options
setopt BASH_AUTO_LIST
setopt CHASE_DOTS
setopt CHASE_LINKS
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt MAGIC_EQUAL_SUBST
setopt MULTIBYTE
setopt NUMERIC_GLOB_SORT

# Globbing options
setopt GLOB_COMPLETE
setopt NUMERIC_GLOB_SORT
setopt NO_CASE_GLOB
setopt EXTENDEDGLOB

# History options
HISTFILE="${XDG_DATA_HOME}/.zsh_history"
HISTSIZE=15000
SAVEHIST=15000
setopt APPENDHISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Unset annoying things
unsetopt BEEP
unsetopt AUTOCD

# Use the GnuPG agent as SSH agent
GPG_AGENT_SSH_SOCKET="$(gpgconf --list-dirs agent-ssh-socket)"
[[ -s "${GPG_AGENT_SSH_SOCKET}" ]] && \
	export SSH_AUTH_SOCK="${GPG_AGENT_SSH_SOCKET}"

# Enable fzf (pacman -S fzf)
if [[ -d "/usr/share/fzf" ]]; then
	source "/usr/share/fzf/key-bindings.zsh"
	source "/usr/share/fzf/completion.zsh"
fi

# Enables bash-isms
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^r' history-incremental-search-backward
# Enable vim-like keybindings
bindkey -v
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward
bindkey -M vicmd "q" push-line
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'u' undo

# commandline completion
setopt COMPLETE_ALIASES
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
autoload -Uz compinit; compinit

# If zsh-completion is missing for a command, then bash-completion can be used in its stead. 
# (Not 100% sure about this)
# autoload -U +X bashcompinit && bashcompinit
# eval $(pandoc --bash-completion)

# No idea what this does, disabled
# zmodload -i zsh/complist

# easy to use zsh hooks that does nothing at the moment
[[ -r "${HOME}/.zsh/hooks" ]] && source "${HOME}/.zsh/hooks"

# Prompt
fpath=( "${HOME}/.zsh/prompts" $fpath )
autoload -Uz promptinit; promptinit
prompt bee16

# Source ~/.funcs and ~/.alias
[[ -r "${HOME}/.funcs" ]] && source "${HOME}/.funcs"
[[ -r "${HOME}/.alias" ]] && source "${HOME}/.alias"
