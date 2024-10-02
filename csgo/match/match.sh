#!/bin/bash

shell=$(basename "$0")

## How many instances to create?
INSTANCE_COUNT=6

## Function Declaration
function start() {
  mkdir -p data
  chmod 777 -R data
  chown sysoper:sysoper -R data

  for MATCH in $(eval echo {1..$INSTANCE_COUNT}); do
    docker compose --env-file ./matches/$MATCH.env --project-name "csgo_match_$MATCH" up -d --force-recreate
  done

}

function stop() {
  for MATCH in $(eval echo {1..$INSTANCE_COUNT}); do
    docker compose --project-name "csgo_match_$MATCH" down
  done
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
