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
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'u' undo

# Alt+Left: Previous Directory
bindkey '^[[1;3D' cdPrevDir
# Alt+Up: Parent Directory
bindkey '^[[1;3A' cdParentDir

