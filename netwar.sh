#!/bin/bash

shell=$(basename "$0")

game_exec_list=(
  'connect/connect.sh'
  'cs2/casual/cs2.sh'
  'csgo/casual/csgo.sh'
  'cstrike/cstrike.sh'
  'garrysmod/garrysmod.sh'
  'l4d2/l4d2.sh'
  'minecraft/minecraft.sh'
  'prophunt/tf2.sh'
  'rust/rust.sh'
  'tf2/tf2.sh'
  'ut2004/ut2004.sh'
  )

main_dir=$(pwd)

## Function Declaration
function start() {
  ## turn up all casual servers
  this_state="up"

  for game in "${game_exec_list[@]}"; 
  do
    echo "Starting $game"
    cd $main_dir/$(dirname $game)
    bash $(basename $game) $this_state
  done
}

function stop() {
  ## turn down all casual servers
  this_state="down"

  for game in "${game_exec_list[@]}"; 
  do
    echo "Stopping $game"
    cd $main_dir/$(dirname $game)
    bash $(basename $game) $this_state
  done
}

function restart() {
  stop && start
}

function help() {
  echo "Commands should look like:"
  echo "  $shell up       Start the server"
  echo "  $shell down     Stop the server"
  echo "  $shell restart  Restart the server"
  echo "  $shell update   Pull new docker image"
  echo "  $shell help     Show this help page"
}

function update() {
  ## turn down all casual servers
  this_state="update"

  for game in "${game_exec_list[@]}"; 
  do
    echo "Stopping $game"
    cd $main_dir/$(dirname $game)
    bash $(basename $game) $this_state
  done
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
else
  help
fi