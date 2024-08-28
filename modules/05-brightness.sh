## Display module ##

## Colors

function run() {
    PERCENT=$(brightnessctl | grep Current | awk '{ print $4 }' | sed "s/(//g" | sed "s/)//g")
    ICO="💡"
    echo "${ICO}${PERCENT}"
}
