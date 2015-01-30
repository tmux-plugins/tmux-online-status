#!/bin/bash

airport_path='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

get_ssid()
{
    if [[ ! -x $airport_path ]]; then
        return 1
    fi

    local all_signal=(▂ ▅ ▇)

    # Search information about Wi-Fi by using airport command
    local current=$(bash -c "$airport_path -I" | egrep "agrCtlRSSI|state|lastTxRate| SSID" | tr "\\n" ";" | awk '{print $2,$4,$6,$8}')
    if [[ $current == "" ]]; then
        return 1
    fi

    local strength=$(echo "$current" | cut -d";" -f1-1 | cut -d" " -f2-)
    local state=$(echo "$current" | cut -d";" -f2-2 | cut -d" " -f2-)
    local bandwidth=$(echo "$current" | cut -d";" -f3-3 | cut -d" " -f2-)
    local name=$(echo "$current" | cut -d";" -f4-4 | cut -d" " -f2-)

    # Decide the number of radio waves
    local signal=""
    for ((j = 0; j < 3; j++)); do
        if [[ $j -eq 0 && $strength -gt -100 ]] ||
            [[ $j -eq 1 && $strength -gt -80 ]] ||
            [[ $j -eq 2 && $strength -gt -50 ]]; then
        signal="${signal}${all_signal[$j]} "
    else
        signal="${signal}  "
    fi; done

    if [[ "$1" == '-v' ]]; then
        printf "${name} ${bandwidth}Mbs ${signal}\n"
    else
        printf "${name}\n"
    fi
}

get_ssid "$@"
