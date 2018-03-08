#!/bin/bash

function rts-bus {
  TIME=$(curl --silent "https://ufl.transloc.com/t/stops/4093254" | egrep -o 'title="View all of Butler Plaza">[0-9 &]*<' | cut -c 34- | rev | cut -c 3- | rev)
  printf "%s" "Butler Plaza: $TIME min 🚌 "
}
