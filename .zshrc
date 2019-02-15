# vim: ft=zsh sw=4 ts=4

# This is a tmpfs in my case and that has implications on the
# completion system (e.g compinit's .zcompdump will routinely get rebuilt as ~/.cache is cleared)
_ZSH_CACHE="${HOME}/.cache/zsh"
mkdir -p "${_ZSH_CACHE}"
mkdir -p "${XDG_DATA_HOME}/zsh"

# Debugging (You might want to turn these off)
zmodload zsh/zprof
#setopt SOURCE_TRACE
#setopt WARN_CREATE_GLOBAL
#setopt WARN_NESTED_VAR
#setopt PRINT_EXIT_VALUE
#setopt EVAL_LINENO

# Enable ZLE
setopt ZLE

# Enable vim-like line-editing
setopt VI

# Output hexadecimal in the standard C format of `0xFF` instead of `16#FF`
setopt C_BASES

# Notify when jobs finish
# setopt NOTIFY

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
HISTFILE="${XDG_DATA_HOME}/zsh/.zsh_history"
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

# Source functions
[[ -r "${HOME}/.funcs" ]] && source "${HOME}/.funcs"

# Using gpg as ssh agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export DEBUG_SSH_AUTH_SOCKET="$(gpgconf --list-dirs agent-extra-socket)"

# Enable fzf (pacman -S fzf)
if [[ -d "/usr/share/fzf" ]]; then
	source "/usr/share/fzf/key-bindings.zsh"
	source "/usr/share/fzf/completion.zsh"
fi

bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^r' history-incremental-search-backward
bindkey -v
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward
bindkey -M vicmd "q" push-line
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'u' undo

# commandline completion
if hash pandoc 2>/dev/null; then
	eval $(pandoc --bash-completion)
fi
#autoload -U +X bashcompinit && bashcompinit

ZLS_COLORS=""; zmodload -i zsh/complist

setopt COMPLETE_ALIASES
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${_ZSH_CACHE}
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

autoload -Uz compinit
rm -rf "${_ZSH_CACHE}/.zcompdump"
compinit -C -d "${_ZSH_CACHE}/.zcompdump"

# easy to use zsh hooks that does nothing at the moment
[[ -r "${HOME}/.zsh/hooks" ]] && source "${HOME}/.zsh/hooks"

# Prompt
fpath=( "${HOME}/.zsh/prompts" $fpath )
autoload -Uz promptinit; promptinit

# Thanks to Sindre Sorhus for the great pure-prompt
# https://github.com/sindresorhus/pure
PURE_CMD_MAX_EXEC_TIME=1 # 5
PURE_PROMPT_SYMBOL=""
PURE_PROMPT_VICMD_SYMBOL="ᝰ "
# PURE_GIT_UNTRACKED_DIRTY=0
# PURE_GIT_DELAY_DIRTY_CHECK=1800
# PURE_GIT_DOWN_ARROW="⇣"
# PURE_GIT_UP_ARROW="⇡"
# PURE_GIT_PULL=0

# I have added some custom modifications and impurities to the
# theme which are explained/configured as follows

# Display poops proportional to clutter in your homedir
IMPURE_CLUTTER_POOP=1

# Adds a "permission denied" symbol to the path if its read-only to the user
IMPURE_READ_ONLY_PATH_SYMBOL="%F{red} %f"

# Path is replaced with the map value of the key matches the pwd exactly
declare -A IMPURE_REPLACE_PATH=(
	[~]="%F{green}  ~"
	[/]="%F{red}/%f"
	[/cloud]="%F{white}/cloud  %f"
	[/tmp]="%F{white}/tmp  %f"
	[/usr/local/src]="%F{yellow}/usr/local/src%f"
)

# Map value is prepended to the path if the key matches any part of the pwd
declare -A IMPURE_PREPEND_PATH=(
	[bin]="%F{magenta}"
	[eikaas]="%F{yellow}"
	[code]="%F{yellow}"
)

# Map value is appended to the end of the path if the key matches any part of the pwd
declare -A IMPURE_APPEND_PATH=(
	[/home/robin]="%F{green} %f"
	[bin]="%F{yellow} %f"
	[eikaas]=" %f"
	[code]=" %f"
	[.git]="%F{purple} %f"
)
prompt pure

# Source ~/.alias
[[ -r "${HOME}/.alias" ]] && source "${HOME}/.alias"

# Test
setopt auto_name_dirs
setopt auto_list
setopt auto_menu

# No delay for normal mode
KEYTIMEOUT=1

# Set space as the 'leader' key
bindkey -a -r ' '
# Open man-page on current command (Leaves command untouched) (Esc+space+m)
bindkey -a ' 'm run-help

# `less` colors
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[01;32m' 			# begin underline
