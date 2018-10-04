# Where to save the history
export HISTFILE="${ZDATADIR}/.zsh_history"

# Number of lines kept in a session 
export HISTSIZE=500

# Max number of lines kept in the history file
export SAVEHIST=100000

# Important to avoid wiping out your history
setopt APPEND_HISTORY
# Writes to the history file as lines are executed
setopt INC_APPEND_HISTORY       

# Needed to save correct run time when EXTENDED_HISTORY is defined
setopt INC_APPEND_HISTORY_TIME

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

# Ignore lines starting with space
setopt HIST_IGNORE_SPACE

# Ignore subsequent dupes
setopt HIST_IGNORE_DUPS

# Dont list duplicates when searching history
setopt HIST_FIND_NO_DUPS

# Timestamp history
setopt EXTENDED_HISTORY
