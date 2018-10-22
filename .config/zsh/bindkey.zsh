bindkey -v

# Enable bash-isms
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^r' history-incremental-search-backward

# Enable vi-mode
setopt VI
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward
bindkey -M vicmd "q" push-line
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'u' undo

# Alt+Left: Previous Directory
bindkey '^[[1;3D' cdPrevDir
# Alt+Up: Parent Directory
bindkey '^[[1;3A' cdParentDir
# Alt+S
bindkey "^[s" sudo-inject

bindkey -M vicmd "q" push-line

bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\eOB' down-line-or-history
