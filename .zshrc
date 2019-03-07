# vim: ft=zsh sw=4 ts=4
fpath=(
	"${HOME}/.zsh/completions"
	"${HOME}/.zsh/prompts"
	$fpath
)
ZCOMPDUMP="${HOME}/.cache/zsh/.zcompdump"

# Debugging (You might want to turn these off)
# zmodload zsh/zprof
# setopt SOURCE_TRACE
# setopt WARN_CREATE_GLOBAL
# setopt WARN_NESTED_VAR
# setopt PRINT_EXIT_VALUE
# setopt EVAL_LINENO

# Enable ZLE
setopt ZLE

# Enable vim-like line-editing
setopt VI

# Output hexadecimal in the standard C format of `0xFF` instead of `16#FF`
setopt C_BASES

# Allow Multiple pipes, sounds like something we'd like
setopt MULTIOS

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS
setopt AUTO_NAME_DIRS

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
# Don't overwrite, append
setopt APPENDHISTORY

# Write history after every command
setopt INC_APPEND_HISTORY

# Share history between shells
setopt SHARE_HISTORY

# Ignore repeating commands
setopt HIST_IGNORE_DUPS

# ... even if there are a few commands in between the dupes
setopt HIST_IGNORE_ALL_DUPS

# Reduce blanks,       its nice
setopt HIST_REDUCE_BLANKS

# Don't log lines starting with space
setopt HIST_IGNORE_SPACE
# Not sure what this does, but its present on the box where my history is working
setopt HIST_NO_STORE

# Save the time and duratoin of commands
setopt EXTENDED_HISTORY

# Dont save duplicate hitoric entries
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-separator 'fREW'

# Unset annoying things
unsetopt BEEP
unsetopt AUTOCD

# Source functions
[[ -r "${HOME}/.funcs" ]] && source "${HOME}/.funcs"

# Using gpg as ssh agent
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export DEBUG_SSH_AUTH_SOCKET="$(gpgconf --list-dirs agent-extra-socket)"

# Enable fzf (pacman -S fzf)
[[ -r /usr/share/fzf/key-bindings.zsh ]] && \
	source "/usr/share/fzf/key-bindings.zsh"
[[ -r "/usr/share/fzf/completion.zsh" ]] && \
	source "/usr/share/fzf/completion.zsh"

bindkey -v
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^r' history-incremental-search-backward
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
compinit -C -d "${ZCOMPDUMP}"

# easy to use zsh hooks that does nothing at the moment
[[ -r "${HOME}/.zsh/hooks" ]] && source "${HOME}/.zsh/hooks"
autoload -Uz promptinit; promptinit

# Thanks to Sindre Sorhus for the great pure-prompt
# https://github.com/sindresorhus/pure
# PURE_GIT_UNTRACKED_DIRTY=0
# PURE_GIT_DELAY_DIRTY_CHECK=1800
PURE_GIT_DOWN_ARROW="⇣"
PURE_GIT_UP_ARROW="⇡"
PURE_CMD_MAX_EXEC_TIME=1
PURE_PROMPT_SYMBOL=""
PURE_PROMPT_VICMD_SYMBOL="ᝰ "
PURE_GIT_PULL=0

IMPURE_PROMPT_SSH_SYMBOL=""
IMPURE_PROMPT_DOCKER_SYMBOL=" "
# IMPURE_READ_ONLY_PATH_SYMBOL="%F{red} %f"
#declare -A IMPURE_REPLACE_PATH=(
#	[~]="~ (%F{red}home%f)"
#	[/]="%F{red}/%f"
#	[/cloud]="%F{white}/cloud  %f"
#	[/tmp]="%F{white}/tmp  %f"
#	[/usr/local/src]="%F{yellow}/usr/local/src%f"
#)

# Map value is prepended to the path if the key matches any part of the pwd
#declare -A IMPURE_PREPEND_PATH=(
#	[bin]="%F{magenta}"
#	[eikaas]="%F{yellow}"
#	[code]="%F{yellow}"
#)

# Map value is appended to the end of the path if the key matches any part of the pwd
# declare -A IMPURE_APPEND_PATH=(
#	[/home/robin]="%F{green} %f"
#	[bin]="%F{yellow} %f"
#	[eikaas]=" %f"
#	[code]=" %f"
#	[.git]="%F{purple} %f"
#)
prompt pure

# Source ~/.alias
[[ -r "${HOME}/.alias" ]] && source "${HOME}/.alias"

# No delay for normal mode
KEYTIMEOUT=1

# Set space as the 'leader' key
bindkey -a -r ' '
# Open man-page on current command (Leaves command untouched) (Esc+space+m)
bindkey -a ' 'm run-help

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export BROWSER=firefox
export EDITOR=vim
export SYSTEMD_EDITOR=vim
export PAGER=nvimpager
export MANPAGER=nvimpager
export TERMINAL=xfce4-terminal

