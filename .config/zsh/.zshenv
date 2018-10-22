export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export TZ="Europe/Oslo"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZDATADIR="${XDG_DATA_HOME}/zsh"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
export _Z_DATA="${XDG_DATA_HOME}/z"

export GOPATH="${HOME}/eikxyz/go"
export PATH="${HOME}/bin:${GOPATH}/bin:${PATH}"

export BROWSER=firefox
export EDITOR=vim
export SYSTEMD_EDITOR=vim
export PAGER=less
export TERMINAL=termite