autoload -Uz promptinit && promptinit
autoload -Uz zsh-mime-setup && zsh-mime-setup
autoload -Uz zcalc

# Save zsh history anywhere but in my homedir
export HISTFILE="${ZDATADIR}/.zsh_history"

# Use GPG as the ssh agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

source "${ZDOTDIR}/options.zsh"
source "${ZDOTDIR}/funcs.zsh"
source "${ZDOTDIR}/bindkey.zsh"
source "${ZDOTDIR}/completion.zsh"

source "${ZDOTDIR}/zplug.zsh"

source "${ZDOTDIR}/alias.zsh"

if [[ -f /.dockerenv ]]; then
  toilet -f smmono12 --gay "You have been contained"
fi

