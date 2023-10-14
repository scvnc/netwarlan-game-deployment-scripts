#!/bin/bash

shell=$(basename "$0")

## Function Declaration
function help() {
  echo "Commands should look like:"
  echo "  $shell gs01       Setup macvlan on gs01"
  echo "  $shell gs02       Setup macvlan on gs02"
  echo "  $shell help       Show this help page"
}


## Grab our argument
state=$1

## Commands
if [[ $state == 'gs01' ]]; then
  docker network create -d macvlan \
    --subnet=10.10.10.0/24 \
    --ip-range=10.10.10.120/28 \
    --gateway=10.10.10.1 \
    -o parent=eno1 vlan

elif [[ $state == 'gs02' ]]; then
  docker network create -d macvlan \
    --subnet=10.10.10.0/24 \
    --ip-range=10.10.10.120/28 \
    --gateway=10.10.10.1 \
    -o parent=ens192 vlan

else
  help
fi
