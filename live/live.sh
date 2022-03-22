#!/bin/bash

mkdir -p html

## Function Declaration
function start() {
  docker-compose up -d --force-recreate

  wget -O html/index.html https://raw.githubusercontent.com/netwarlan/webplayer/master/index.html
  docker-compose logs -f
}

function stop() {
  docker-compose down --remove-orphans
}

function restart() {
  stop && start
}

function help() {
  echo "Commands should look like:"
  echo "  live.sh up       Start the server"
  echo "  live.sh down     Stop the server"
  echo "  live.sh restart  Restart the server"
  echo "  live.sh logs     Outputs docker STD log"
  echo "  live.sh update   Pull new docker image"
  echo "  live.sh help     Show this help page"
}

function update() {
  docker-compose pull
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