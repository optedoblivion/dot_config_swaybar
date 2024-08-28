#!/bin/sh

## Some basic colors
FG='#EEEEEE'
BG='#111111'
FONT='-*-clean-*-*-*-*-12-*-*-*-*-*-*-*'
SEP="["
CLOSE_SEP="]"
MODULEPATH="$HOME/.config/swaybar/modules"
ICONPATH="$HOME/.config/swaybar/assets/xbm"
NOTIFYICONPATH="$HOME/.config/swaybar/notify_icons"
COLOR_CLEAR="^fg()"
COLOR_CLEAR=""

MODULES=$(ls $MODULEPATH)
BAR=""
for module in $(echo $MODULES); do
    source "$MODULEPATH/$module"
    BAR="${SEP}$(run)${CLOSE_SEP}-${COLOR_CLEAR}${BAR}"
done
echo "${BAR}"
