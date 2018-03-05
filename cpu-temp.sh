#!/bin/bash

function cpu-temp {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    ISTATS=$(istats)
    TEMP=$(echo $ISTATS | egrep -o "temp: [0-9.]*°C" | cut -c 6-)
    printf "%s" $TEMP;
  elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    TEMP=$(cat /sys/class/thermal/thermal_zone*/temp)
    for it in $TEMP; do printf "%s°C" $(( $it / 1000 )); done
  fi
}
