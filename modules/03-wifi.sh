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
    SIGNAL="$(nmcli device wifi | grep "*" | awk '{ print $9 }')"
    SIGNAL="$(nmcli device wifi | grep "*" | xargs | sed "s/.*Infra/Infra/" | sed "s/ Infra//" | cut -d ' ' -f 6)"
    SSID="$(nmcli device wifi | grep "*" | xargs | sed "s/Infra.*/Infra/" | sed "s/ Infra//" | cut -d ' ' -f 3-)"
    if [ "${SSID}" == "" ]; then
        echo "${ICO}][ Not Connected "
    else
        echo "${ICO}][${SSID} ${SIGNAL} (${PERCENT}%)"
    fi
}
