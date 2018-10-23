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

setxkbmap -layout us -variant mac -option 'ctrl:nocaps' -option 'apple:alupckeys'
dbus-daemon --session --fork
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

monSha="$(xrandr | egrep "\sconnected" | sort | awk '{print $1}' | sha1sum | awk '{print $1}')"
if [[  "${monSha}" == "312aa0f7210f834848c9ce9518fc02cb97e4d576" ]]; then
  xrandr --output VIRTUAL1 --off 
         --output DP1 --mode 2560x1440 --pos 2560x0 --rotate normal \
         --output HDMI2 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
         --output eDP1 --off
fi

exec i3

