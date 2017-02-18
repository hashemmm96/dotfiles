#!/bin/bash
setxkbmap se
[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources
xset -b &
xss-lock -- sflock -f 9x15 & 
setxkbmap -option ctrl:nocaps &
xbindkeys &
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
compton -b &
exec herbstluftwm --locked

# bar before wm
# Put 'exec herbstluftwm' or other wm or de last 
# because otherwise the other commands don't get executed
