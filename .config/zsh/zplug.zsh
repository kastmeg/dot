#
# zplug ensures plugins mentioned in this file are installed & up to date 
# Can install much more than just plugins. (Check out github.com/zplug/zplug)
#
source "${ZPLUG_HOME}/init.zsh"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "chriskempson/base16-shell"
zplug "akz92/clean", as:theme

# Don't bother unless existance is more than
# a brief and meaningless hack
if [[ $(hostname) != "zplug_hack_tmp" ]]; then
    if ! zplug check --verbose; then
        zplug install
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
fi

zplug load

