#!/bin/bash

function battery {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    ISTATS=$(istats)
    PERCENTAGE=$(echo $ISTATS | egrep -o "Current charge.* Max" | egrep -o "[0-9]*%")
    printf "%s" "$PERCENTAGE"
  elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    PERCENTAGE=$(upower -i $(upower -e | grep '/battery') | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)
    printf "%s" "$PERCENTAGE%"
  fi
}
