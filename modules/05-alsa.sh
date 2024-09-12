## ALSA monitoring module ##

## Colors
COLOR_MUTE="^fg(red)"

function run() {
    ismute=$(awk -F"[][]" '/Playback/ { print $4 }' <(amixer sget Master) | uniq | tr -d ' ' | tr -d '\n' | cut -d '%' -f 1)
    if [ "$ismute" == "off" ]; then
        VBS="0"
        ICO="🔇"
    else
        VBS=$(awk -F"[][]" '/Playback/ { print $2 }' <(amixer sget Master) | uniq | tr -d ' ' | tr -d '\n' | cut -d '%' -f 1)
        if [ $VBS -gt 70 ]; then
            ICO="🔊"
        elif [ $VBS -lt 70 ] && [ $VBS -gt 20 ]; then
            ICO="🔉"
        elif [ $VBS -lt 20 ] && [ $VBS -gt 1 ]; then
            ICO="🔈"
        elif [ $VBS -lt 1 ]; then
            ICO="🔇"
        else
            ICO="🔊"
        fi
    fi

    VBAR="$VBS%"
    echo "${ICO}${VBAR}"
}
