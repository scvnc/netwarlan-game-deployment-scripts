#!/bin/bash

shell=$(basename "$0")

## How many instances to create?
PRO_INSTANCE_COUNT=1
CASUAL_INSTANCE_COUNT=1

## Function Declaration
function start() {
  mkdir -p data
  chmod 777 -R data

  if [ "$PRO_INSTANCE_COUNT" -ne 0 ]; then
    for PROMATCH in $(eval echo {1..$PRO_INSTANCE_COUNT}); do
      docker compose --env-file ./matches-pro/$PROMATCH.env --project-name "cs2_match_pro_$PROMATCH" up -d --force-recreate
    done
  fi

  if [ "$CASUAL_INSTANCE_COUNT" -ne 0 ]; then
    for CASUALMATCH in $(eval echo {1..$CASUAL_INSTANCE_COUNT}); do
      docker compose --env-file ./matches-casual/$CASUALMATCH.env --project-name "cs2_match_casual_$CASUALMATCH" up -d --force-recreate
    done
  fi
}

function stop() {
  if [ "$PRO_INSTANCE_COUNT" -ne 0 ]; then
    for PROMATCH in $(eval echo {1..$PRO_INSTANCE_COUNT}); do
      docker compose --project-name "cs2_match_pro_$PROMATCH" down
    done
  fi

  if [ "$CASUAL_INSTANCE_COUNT" -ne 0 ]; then
    for CASUALMATCH in $(eval echo {1..$CASUAL_INSTANCE_COUNT}); do
      docker compose --project-name "cs2_match_casual_$CASUALMATCH" down
    done
  fi
}

function restart() {
  stop && start
}

function help() {
  echo "Commands should look like:"
  echo "  $shell up       Start the server"
  echo "  $shell down     Stop the server"
  echo "  $shell restart  Restart the server"
  echo "  $shell logs     Outputs docker STD log"
  echo "  $shell update   Pull new docker image"
  echo "  $shell help     Show this help page"
}

function update() {
  docker compose pull
}

function logs() {
  docker compose logs -f
}

## Grab our argument
state=$1

## Commands
if [[ $state == 'up' ]] || [[ $state == 'u' ]] || [[ $state == 'start' ]]; then
  start
elif [[ $state == 'restart' ]] || [[ $state == 'r' ]]; then
  restart
elif [[ $state == 'down' ]] || [[ $state == 'd' ]] || [[ $state == 'stop' ]]; then
  stop
elif [[ $state == 'update' ]]; then
  update
elif [[ $state == 'logs' ]] || [[ $state == 'l' ]]; then
  logs
else
  help
fi
