#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

export POLY_WS_ICON_0="1;%{F$foreground_alt}%{F-} 1"
export POLY_WS_ICON_1="2;%{F$foreground_alt}%{F-} 2"
export POLY_WS_ICON_2="3;%{F$foreground_alt}%{F-} 3"
export POLY_WS_ICON_3="4;%{F$foreground_alt}%{F-} 4"
export POLY_WS_ICON_4="5;%{F$foreground_alt}%{F-} 5"
export POLY_WS_ICON_5="6;%{F$foreground_alt}%{F-} 6"
export POLY_WS_ICON_6="7;%{F$foreground_alt}%{F-} 7"
export POLY_WS_ICON_7="8;%{F$foreground_alt}%{F-} 8"
export POLY_WS_ICON_8="9;%{F$foreground_alt}%{F-} 9"

export MONITOR=eDP1
polybar laptop &

