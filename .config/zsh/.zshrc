autoload -Uz compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup

# Use GPG as the ssh agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

source "${ZDOTDIR}/options.zsh"
source "${ZDOTDIR}/funcs.zsh"
source "${ZDOTDIR}/bindkey.zsh"
source "${ZDOTDIR}/completion.zsh"
source "${ZDOTDIR}/zplug.zsh"
source "${ZDOTDIR}/alias.zsh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/robin/xyz/go/bin/gocomplete go
