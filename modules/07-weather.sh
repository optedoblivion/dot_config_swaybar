#!/bin/bash

# 5 Minutes
let THRESHOLD=5*60

NEW_DT=$(date +"%s")
NEW_FILE="/tmp/geo-ip-weather.dat.${NEW_DT}"

CURRENT_FILE="$(find /tmp -name \"*geo-ip-weather.dat.*\" 2>/dev/null)"
CURRENT_FILE=$(find /tmp -name "*geo-ip-weather.dat.*")
CURRENT_DT=""

DATA=""
if [ "${CURRENT_FILE}" != "" ]; then
    CURRENT_DT="$(echo ${CURRENT_FILE} | cut -d '.' -f 3)"
    let DIFF=$NEW_DT-$CURRENT_DT
    if [ $DIFF -gt $THRESHOLD ]; then
        rm "${CURRENT_FILE}"
        DATA="$(~/.gungnir/geo-ip-weather.sh)"
        echo "${DATA}" >"${NEW_FILE}"
    else
        DATA="$(cat $CURRENT_FILE)"
    fi
else
    DATA="$(~/.gungnir/geo-ip-weather.sh)"
    echo "${DATA}" >"${NEW_FILE}"
fi

CLOUD="☁"
CLOUD_WITH_RAIN="🌧"
CLOUD_WITH_SNOW="🌨"
CLOUD_WITH_LIGHTNING="🌩"
CLOUD_WITH_LIGHTNING_AND_RAIN="⛈"
CLOUD_SUN_BEHIND="⛅"
CLOUD_BEHIND_LARGE_CLOUD="🌥"

GLOBE_ICON_AMERICA="🌎"
GLOBE_ICON_EUROPE="🌍"
GLOBE_ICON_ASIA="🌏"

NORTH_ARROW="↑"
NORTH_EAST_ARROW="⬈"
NORTH_WEST_ARROW="⬉"
SOUTH_ARROW="↓"
SOUTH_EAST_ARROW="⬊"
SOUTH_WEST_ARROW="⬋"
EAST_ARROW="→"
WEST_ARROW="←"

LOCATION_ICON="${GLOBE_ICON_AMERICA}"
TEMP_ICON="🌡️"
UVI_ICON="🔆"
WIND_ICON="🍃"
HUMIDITY_ICON="💧"

function run() {
    LOCATION=$(echo ${DATA} | cut -d '-' -f 1 | cut -d ':' -f 1 | sed "s/Weather in//g" | tr -d ' ')
    TEMP=$(echo ${DATA} | cut -d '-' -f 1 | cut -d ':' -f 2 | tr -d ' ')
    FEELS_LIKE=$(echo ${DATA} | cut -d '-' -f 2 | cut -d ':' -f 2 | tr -d ' ')
    UVI=$(echo ${DATA} | cut -d '-' -f 3 | cut -d ':' -f 2 | tr -d ' ')
    WIND_BASE=$(echo ${DATA} | cut -d '-' -f 4 | cut -d ':' -f 2)
    WIND=$(echo "${WIND_BASE}" | cut -d ' ' -f 2,3)
    WIND_DIRECTION_BASE=$(echo "${WIND_BASE}" | cut -d ' ' -f 4 | tr -d ' ')
    WIND_DIRECTION="$WIND_DIRECTION_BASE"
    if [ "${WIND_DIRECTION_BASE}" == "N" ]; then
        WIND_DIRECTION="${NORTH_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "NW" ]; then
        WIND_DIRECTION="${NORTH_WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "NNW" ]; then
        WIND_DIRECTION="${NORTH_WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "NE" ]; then
        WIND_DIRECTION="${NORTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "NNE" ]; then
        WIND_DIRECTION="${NORTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "S" ]; then
        WIND_DIRECTION="${SOUTH_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "SW" ]; then
        WIND_DIRECTION="${SOUTH_WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "SSW" ]; then
        WIND_DIRECTION="${SOUTH_WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "SE" ]; then
        WIND_DIRECTION="${SOUTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "SSE" ]; then
        WIND_DIRECTION="${SOUTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "E" ]; then
        WIND_DIRECTION="${EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "ESE" ]; then
        WIND_DIRECTION="${SOUTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "ENE" ]; then
        WIND_DIRECTION="${NORTH_EAST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "W" ]; then
        WIND_DIRECTION="${WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "WSW" ]; then
        WIND_DIRECTION="${SOUTH_WEST_ARROW}"
    elif [ "${WIND_DIRECTION_BASE}" == "WNW" ]; then
        WIND_DIRECTION="${NORTH_WEST_ARROW}"
    fi
    HUMIDITY=$(echo ${DATA} | cut -d '-' -f 5 | cut -d ':' -f 2 | tr -d ' ')
    PRESSURE=$(echo ${DATA} | cut -d '-' -f 6 | cut -d ':' -f 2 | tr -d ' ')

    echo "${CLOUD_SUN_BEHIND}][${LOCATION_ICON}${LOCATION} ${TEMP_ICON}${TEMP}(${FEELS_LIKE}) ${UVI_ICON}${UVI} ${WIND_ICON}${WIND}${WIND_DIRECTION} ${HUMIDITY_ICON}${HUMIDITY}"
    # echo "${DATA}"
}
