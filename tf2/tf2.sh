#!/bin/bash

shell=$(basename "$0")

## Function Declaration
function start() {
  mkdir -p data
  docker compose up -d --force-recreate
  docker compose logs -f
}

function stop() {
  docker compose down --remove-orphans
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