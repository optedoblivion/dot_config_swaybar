## Display module ##

## Colors
COLOR_CRITICAL="^fg(red)"

function run() {
    PLATFORM_PROFILE=$(cat /sys/firmware/acpi/platform_profile)
    CPU_SPEED=$(cpupower frequency-info | grep "asserted by call to kernel" | awk '{ print $4$5 }')
    ICO="💻"
    PERF_ICO=""
    if [ "${PLATFORM_PROFILE}" == "balanced" ]; then
        PERF_ICO="❭"
    elif [ "${PLATFORM_PROFILE}" == "performance" ]; then
        PERF_ICO="🚀"
    elif [ "${PLATFORM_PROFILE}" == "low-power" ]; then
        PERF_ICO="🐌"
    fi

    TMP="$(sensors | grep CPU | awk '{ print $2 }' | cut -d '.' -f 1 | sed s/+//g)"
    TEMP_ICO="🌡️"

    MAX=$(free -m | grep Mem | awk '{ print $2 }')
    USE=$(free -m | grep Mem | awk '{ print $3 }')
    #    PLUSMINUS=$(free -m | grep "\-/+" | awk '{ print $3 }')
    #    USE=$(echo "$USE - $PLUSMINUS" | bc -q 2>/dev/null)
    PERCENT=$(echo "scale=2; ($USE/$MAX) * 100" | bc -q 2>/dev/null)
    PERCENT=$(echo "$PERCENT" | cut -d '.' -f 1)
    RAM_ICO="🐐"
    if [ $PERCENT -gt 90 ]; then
        COLOR="$COLOR_CRITICAL"
    fi

    echo "${ICO}${CPU_SPEED}${PERF_ICO}${TEMP_ICO}${TMP}°C${RAM_ICO}${PERCENT}%"
}
