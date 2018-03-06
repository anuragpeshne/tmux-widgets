#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $DIR/vars

function weather {
  # Adapted from https://jezenthomas.com/showing-the-weather-in-tmux/
  # by Jezen Thomas <jezen@jezenthomas.com>
  set -e

  # Not all icons for weather symbols have been added yet. If the weather
  # category is not matched in this case statement, the command output will
  # include the category ID. You can add the appropriate emoji as you go along.
  #
  # Weather data reference: http://openweathermap.org/weather-conditions
  weather_icon() {
    case $1 in
      500) echo 🌦
        ;;
      800) echo ☀️
        ;;
      801) echo 🌤
        ;;
      802) echo ⛅️
        ;;
      803) echo 🌥
        ;;
      804) echo ☁️
        ;;
      *) echo "$1"
    esac
  }

  # don't refresh unless 10 min older data
  if [ ! -f /tmp/weather ] || [ $(( $(date +%s) - $(stat -f%c /tmp/weather) )) -gt 600 ]; then
    echo "curling at $(date)" >> /tmp/wlog
    curl --silent http://api.openweathermap.org/data/2.5/weather\?lat="$LATITUDE"\&lon="$LONGITUDE"\&APPID="$WEATHER_KEY"\&units=metric > /tmp/weather
  fi
  WEATHER=$(cat /tmp/weather)

  CITY=$(echo $WEATHER | egrep -o 'name":"[a-zA-Z]*"' | cut -c 8- | rev | cut -c 2- | rev)
  TEMP=$(echo $WEATHER | egrep -o 'temp":[0-9.]*,' | cut -b 7- | rev | cut -c 2- | rev)
  CATEGORY=$(echo $WEATHER | egrep -o 'weather":\[{"id":...' | cut -b 17-19)
  WIND_SPEED=$(echo $WEATHER | egrep -o 'wind":{"speed":[0-9.]*,' | cut -c 16- | rev | cut -c 2- | rev)
  ICON=$(weather_icon "$CATEGORY")

  printf "%s" "$CITY:$TEMP °C, $WIND_SPEED $ICON "
}
