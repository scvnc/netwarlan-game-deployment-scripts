#!/bin/bash
source .env

command='changelevel de_dust2'

ips=("10.10.10.140" 
     "10.10.10.141" 
     "10.10.10.142" 
     "10.10.10.143" 
     "10.10.10.144" 
     "10.10.10.145" 
     "10.10.10.146" 
     "10.10.10.147" 
     "10.10.10.148" 
     "10.10.10.149" 
     "10.10.10.150" 
     "10.10.10.151" 
     "10.10.10.152")

port="27015"

for ip in ${ips[@]}; do
  docker run -it --platform linux/x86_64 --rm outdead/rcon ./rcon \
    --address $ip:$port \
    --password $password \
    "${command}"
done
