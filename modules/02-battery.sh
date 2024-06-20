## Battery Module ##

SCRIPT_ROOT_DIR="$(dirname $0)"

function run() {
    TIME=""
    STATE=$(acpi | awk '{ print $3 }' | sed s/,//g)
    if [ "$STATE" != "Discharging" ]; then
        PERCENT=$(acpi | awk ' {print $4 }' | sed s/,//g)
        ICO="⚡"
    else
        PERCENT=$(acpi | awk ' {print $4 }' | sed s/,//g)
        NUM=$(echo $PERCENT|sed s/\%//)
        if [ "$NUM" -gt "75" ]; then
            ICO="🔋"
            rm -f /tmp/battery_critical
        elif [ "$NUM" -gt "20" ]; then
            ICO="🔋"
            rm -f /tmp/battery_critical
        elif [ "$NUM" -gt 5 ]; then
            ICO="🪫"
            BATTERY_CRITICAL=$(ls /tmp|grep battery_critical)
            if [ "$BATTERY_CRITICAL" == "" ]; then
                aplay "${SCRIPT_ROOT_DIR}/sounds/mgssoundscheme/mgs2 low battery.wav"&
                swaynag -m "You battery state is low: $PERCENT left."&
                touch /tmp/battery_critical
            fi
            COLOR="$COLOR_ERROR"
        else
            ICO="🪫"
            aplay "${SCRIPT_ROOT_DIR}/sounds/mgssoundscheme/mgs2 critical battery.wav"&
            swaynag -m "You battery state is critical: $PERCENT left; System hibernating!"&
            # TODO Add count down timer and cancel.
            sleep 5
            systemctl suspend-then-hibernate
        fi
    fi
    echo "${ICO}${PERCENT}"
}
