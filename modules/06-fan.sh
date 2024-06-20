## Fan module ##

## Colors

function run() {
#    MIN=$(sensors | grep Exhaust | awk '{ print $7 }')
#    MAX=$(sensors | grep Exhaust | awk '{ print $11 }')
    RPM=$(sensors | grep fan2 | awk '{ print $2 }')
#    let RPM=$RPM-2000
#    PERCENT=$(echo "scale=2; ($RPM/$MAX) * 100" | bc -q 2>/dev/null)
#    PERCENT=$(echo "$PERCENT" | cut -d '.' -f 1)
    echo ""

}
