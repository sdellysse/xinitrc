#!/bin/sh
source $HOME/.bashrc

WM='dwm'

#common setup
(
  killall random_wallpapers >& /dev/null
  random_wallpapers
)&
(
  xset +fp /usr/share/fonts/local
  xset fp rehash
)&
unclutter &
urxvtd -q -o -f &
xrdb -load < ~/.Xdefaults &
ck-launch-session nm-applet --disable-sm &
gvolwheel&

#wm-specific
case "$WM" in
  dwm)
    trayer --align right --height 16 --transparent true --alpha 0 --edge top --widthtype request --margin 145&
    while true; do
      xsetroot -name  "$(date +"%a %b %d %r")"
      sleep 1s
    done&
    exec ssh-agent ~/bin/startdwm
  ;;
  wmfs)
    exec ssh-agent wmfs
  ;;
  awesome)
    exec ssh-agent awesome
  ;;
esac

