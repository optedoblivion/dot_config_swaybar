## wifi monitoring module ##

## Colors
SCRIPT_ROOT_DIR="$(dirname $0)"

ETH_ICON="🌐"
function run() {
    #    ICO="📶"
    PERCENT="$(awk 'NR==3 {print $3 "00 %"}''' /proc/net/wireless | cut -d '.' -f 1)"
    ICO="🛜"
    COLOR="$COLOR_WIFI_FULL"
    if [ $PERCENT -lt 66 ]; then
        #        ICO="^i($ICONPATH/wifi_half.xbm)"
        COLOR="$COLOR_WIFI_HALF"
        if [ $PERCENT -lt 33 ]; then
            #            ICO="^i($ICONPATH/wifi_low.xbm)"
            COLOR="$COLOR_WIFI_LOW"
        fi
    fi
    # TX
    # RX
    echo "${ICO}${PERCENT}%"
}
