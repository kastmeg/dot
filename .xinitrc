#!/usr/bin/env bash

[[ -f "/etc/X11/xinit/.Xresources" ]] && xrdb -merge "/etc/X11/xinit/.Xresources"
[[ -f "$HOME/.Xresources" ]] && xrdb -merge "$HOME/.Xresources"
[[ -f "/etc/X11/xinit/.Xmodmap" ]] && xmodmap "/etc/X11/xinit/.Xmodmap"
[[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"

if [[ -d "/etc/X11/xinit/xinitrc.d" ]]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do 
    [[ -x "$f" ]] && source "$f"
  done
  unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
dbus-daemon --session --fork

