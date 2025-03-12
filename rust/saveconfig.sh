#!/bin/bash

# Ideally, this saves a snapshot of the server/mod config files so that we can apply them later


# We want to preserve the structure, so ensure config directories exist where we are copying the files to 
mkdir -p config/oxide config/server/rust/cfg

# # save the oxide mods

# ## ensure we are only copying over the exact set of plugins
rm -r config/oxide/plugins

# ## copy over oxide plugins
cp -r data/oxide/plugins data/oxide/config config/oxide

# # save the rust server config
cp data/server/rust/cfg/* config/server/rust/cfg/


echo "saved all config files to the config dir"
