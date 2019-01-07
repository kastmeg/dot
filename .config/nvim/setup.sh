#!/usr/bin/env bash
# This script ensures the plugin handler junegunn/vim-plug is installed
set -eo pipefail
die() { echo "$@" 2>/dev/stderr; exit 1; }

curl -sSLfo "${XDG_DATA_HOME:-~/.local/share}/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || die "Failed to install plug.vim"

vim -c "PlugInstall" -c "exit" -c "exit" || die "Failed to install vim plugins"

