#!/bin/bash

echo "- Wiping map"
find data/server/rust -maxdepth 1 -type f -name "*.map" -delete
find data/server/rust -maxdepth 1 -type f -name "*.sav*" -delete

echo "- Wiping players"
find data/server/rust -maxdepth 1 -type f -name "player.*.db*" -delete
