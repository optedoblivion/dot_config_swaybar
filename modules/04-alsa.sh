## ALSA monitoring module ##

## Colors
COLOR_MUTE="^fg(red)"

function run() {
    ismute=$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master) | cut -d '%' -f 1)
    if [ "$ismute" == "off" ]; then
        VBS="0"
        ICO="🔇"
    else
        VBS=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | cut -d '%' -f 1)
        if [ $VBS -lt 70 ]; then
            ICO="🔉"
        elif [ $VBS -lt 40 ]; then
            ICO="🔈"
        elif [ $VBS -lt 1 ]; then
            ICO="🔇"
        else
            ICO="🔊"
        fi
    fi


    VBAR="$VBS%"
    #echo "$COLOR$VICO $VBAR"
    echo "${ICO}${VBAR}"
}
