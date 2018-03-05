#!/bin/bash

function cpu-temp {
  TEMP=$(cat /sys/class/thermal/thermal_zone*/temp)
  for it in $TEMP; do printf "%s°C" $(( $it / 1000 )); done
}
