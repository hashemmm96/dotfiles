#!/bin/bash
setxkbmap se
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources
mpd ~/.config/mpd/mpd.conf
~/scripts/lightsOn.sh 550 &
xset -b &
xss-lock -- xscreensaver-command -lock  &
xscreensaver &
xbindkeys &
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
compton -b &
exec herbstluftwm --locked

# bar before wm
# Put 'exec herbstluftwm' or other wm or de last 
# because otherwise the other commands don't get executed
