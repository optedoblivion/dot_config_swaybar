# Check if ARP cache has two IP addresses for the same MAC Address
function check_arp_cache() {
    DEFAULT_GATEWAY="$(route | grep default | awk ' { print $2 } ')"
    if [ "${DEFAULT_GATEWAY}" != "" ]; then
        DEFAULT_GW_ARP_MAC="$(arp -a | grep ${DEFAULT_GATEWAY} | awk ' { print $4 } ')"
        ARP_MAC_ENTRY_COUNT="$(arp -a | grep ${DEFAULT_GW_ARP_MAC} | wc -l)"
        ARP_MAC_ENTRIES="$(arp -a | grep ${DEFAULT_GW_ARP_MAC})"

        MAX_ALLOWED_ENTRIES=1

        if [ $ARP_MAC_ENTRY_COUNT -gt $MAX_ALLOWED_ENTRIES ]; then
            SSID="$(nmcli d | grep " connected" | grep -v "loopback" | xargs | cut -d ' ' -f 4-)"
            nmcli con down id "${SSID}"

            exec swaynag -m "Disconnecting from ${SSID}" &
            sleep .01
            exec swaynag -m "${ARP_MAC_ENTRIES}" &
            sleep .01
            exec swaynag -m "Found ${ARP_MAC_ENTRY_COUNT} entries for ${DEFAULT_GW_ARP_MAC}" &
            sleep .01
            exec swaynag -m "ARP Poisoning Detected"
        fi
    fi
}

# Check for unsolicited messages claiming to own either an IP or MAC
# TODO

# Using static ARP is the best option, but not practical on laptop

# Don't wanna do all of the tasks at the same time once we get them since this runs every second.
# We will just perform one task each second and keep going.
# Iteration doesn't work, figure it out later
ICO="🛡"
MAX=1

if [ -z $CCC ]; then
    CCC=0
fi
function run() {
    ACTION=""
    if [ $CCC -eq 0 ]; then
        ACTION="Enforcing ARP"
        check_arp_cache
        let CCC=$CCC+1
    elif [ $CCC -eq $MAX ]; then
        echo -n "shit"
        ACTION="RESTING"
        CCC=0
    fi
    echo -n "$ICO][${ACTION} ${CCC}/${MAX}"
}
