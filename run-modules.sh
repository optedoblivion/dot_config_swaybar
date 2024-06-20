#!/bin/sh

## Some basic colors
FG='#EEEEEE'
BG='#111111'
FONT='-*-clean-*-*-*-*-12-*-*-*-*-*-*-*'
SEP="  "
MODULEPATH="$HOME/.config/swaybar/modules"
ICONPATH="$HOME/.config/swaybar/assets/xbm"
NOTIFYICONPATH="$HOME/.config/swaybar/notify_icons"
COLOR_CLEAR="^fg()"
COLOR_CLEAR=""

MODULES=$(ls $MODULEPATH)
BAR=""
for module in $(echo $MODULES);
do
    source "$MODULEPATH/$module"
    BAR="$(run)${COLOR_CLEAR}${SEP}${BAR}"
done
echo $BAR
