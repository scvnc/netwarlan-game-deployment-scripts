#!/bin/bash

shell=$(basename "$0")

RUST_SERVER_IDENTITY=rust
CONFIG_REPO_PATH=$HOME/netwarlan-server-configs
CONFIG_REPO_CLONE_URL=git@github.com:scvnc/netwarlan-server-configs.git
RUST_CONFIG_DIR=${CONFIG_REPO_PATH}/rust

## Function Declaration
function start() {
  mkdir -p data
  chmod 777 -R data
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
  echo "  $shell up          Start the server"
  echo "  $shell down        Stop the server"
  echo "  $shell restart     Restart the server"
  echo "  $shell logs        Outputs docker STD log"
  echo "  $shell saveconfig  Copy local server config to the NW server-config git repo"
  echo "  $shell loadconfig  Apply NW server config to the local ./data directory"
  echo "  $shell wipe        Deletes map and player data"
  echo "  $shell help        Show this help page"
}

function update() {
  docker compose pull
}

function logs() {
  docker compose logs -f
}

function establish_config_repo() {
  set -e
  if test -d "${CONFIG_REPO_PATH}"; then
    echo ✅ already cloned netwarlan-server-configs
    return 0
  fi

  git clone ${CONFIG_REPO_CLONE_URL} ${CONFIG_REPO_PATH}
  set +e
}

function saveconfig() {
  establish_config_repo
  
  echo "🔵 FYI, I'm assuming you configured the RUST_SERVER_IDENTITY with as 'rust'"

  test -d data || {
    echo "did not find the data mount for the rust container.. have you started the server at least once before?"
    exit 1
  }

  

  # We want to preserve the structure, so ensure config directories exist where we are copying the files to 
  mkdir -p ${RUST_CONFIG_DIR}/oxide ${RUST_CONFIG_DIR}/server/${RUST_SERVER_IDENTITY}/cfg

  # # save the oxide mods

  # ## ensure we are only copying over the exact set of plugins
  rm -r ${RUST_CONFIG_DIR}/oxide/plugins

  # ## copy over oxide plugins
  cp -r data/oxide/plugins data/oxide/config ${RUST_CONFIG_DIR}/oxide

  # # save the rust server config
  cp data/server/${RUST_SERVER_IDENTITY}/cfg/* ${RUST_CONFIG_DIR}/server/${RUST_SERVER_IDENTITY}/cfg/


  echo "Saved all config files to the config dir. I will do a git diff to show any changed files ..."

  set -x
  git -C ${CONFIG_REPO_PATH} diff --name-only
}

function loadconfig() {
  establish_config_repo
  
  echo "🔵 FYI, I'm assuming you configured the RUST_SERVER_IDENTITY with as 'rust'"

  cp -rv ${RUST_CONFIG_DIR}/* data/

}

function wipe() {
  # Prompt the user for confirmation
  read -p "Are you sure you want to wipe the map and players? (y/n): " confirmation

  # Convert the confirmation to lowercase
  confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')

  # Exit if the user does not confirm with 'y' or 'yes'
  if [[ "$confirmation" != "y" && "$confirmation" != "yes" ]]; then
      echo "Wipe canceled."
      exit 1
  fi

  echo "- Wiping map"
  find data/server/${RUST_SERVER_IDENTITY} -maxdepth 1 -type f -name "*.map" -delete
  find data/server/${RUST_SERVER_IDENTITY} -maxdepth 1 -type f -name "*.sav*" -delete

  echo "- Wiping players"
  find data/server/${RUST_SERVER_IDENTITY} -maxdepth 1 -type f -name "player.*.db*" -delete
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
elif [[ $state == 'establish_config_repo' ]]; then
  establish_config_repo
elif [[ $state == 'saveconfig' ]]; then
  saveconfig
elif [[ $state == 'loadconfig' ]]; then
  loadconfig
elif [[ $state == 'wipe' ]]; then
  wipe
else
  help
fi