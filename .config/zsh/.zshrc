autoload -Uz promptinit && promptinit
autoload -Uz zsh-mime-setup && zsh-mime-setup
autoload -Uz zcalc

# Use GPG as the ssh agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

source "${ZDOTDIR}/options.zsh"
source "${ZDOTDIR}/funcs.zsh"
source "${ZDOTDIR}/bindkey.zsh"
source "${ZDOTDIR}/completion.zsh"
source "${ZDOTDIR}/history.zsh"
source "${ZDOTDIR}/zplug.zsh"
source "${ZDOTDIR}/alias.zsh"

