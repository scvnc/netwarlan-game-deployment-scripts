# Game Deployment Scripts
This repo serves as a starting point for all game server configurations deployed at an event.

### Getting Started
Each directory is named for the service in which it deploys. Inside that directory, you'll find a bash script (same as parent folder) that allows some basic handling of the service. Services may be different so consult the `help` menu from each service for a list of options available.

To get started, we'll need to ensure our MAC vlan has been configured as a Docker network. To do that, we'll issue the following:
```
./setup_macvlan.sh gs01
```
This will build out the appropriate networking so that Docker can assign IPs to promiscuous MAC addresses.

Once the network has been created, we'll issue:
```
./netwar.sh up
```
Running this command will automatically pull down all the necessary containers and run each services' `up` command. For the most part, this will start the service, download and apply any updates, and start the service using whatever configuration has been setup on the `compose.yaml` file. 

Other arguments that can be passed:
Argument | Description
-------- | -----------
up | Executes `up` against each service
update | Updates each services images as defined in `compose.yaml`
stop | Executes `down` against each service
restart | Executes `restart` against each service


### IP Address Assignments
The following lists the game servers and their associated IPs:
IP | Server | DNS
-- | ------ | ---
10.10.10.120 | csgo casual 1
10.10.10.121 | csgo casual 2
10.10.10.122 | cstrike snowsk337
10.10.10.123 | garrys mod prop hunt
10.10.10.124 | tf2 casual 1
10.10.10.125 | tf2 mvm
10.10.10.126 | tf2 prop hunt
10.10.10.127 | rust | rust
10.10.10.128 | l4d2 
10.10.10.129 | connect | connect
10.10.10.130 | minecraft | minecraft
10.10.10.131 | cs2 casual 1
10.10.10.132 | cs2 casual 2
10.10.10.133 | ut2004
10.10.10.134 | 
10.10.10.135 | 
10.10.10.136 | 
10.10.10.137 | 
10.10.10.138 | 
10.10.10.139 | 
10.10.10.140 | 
10.10.10.141 | csgo / cs2 match 1 | match1
10.10.10.142 | csgo / cs2 match 2 | match2
10.10.10.143 | csgo / cs2 match 3 | match3
10.10.10.144 | csgo / cs2 match 4 | match4
10.10.10.145 | csgo / cs2 match 5 | match5
10.10.10.146 | csgo / cs2 match 6 | match6
10.10.10.147 | csgo / cs2 match 7 | match7
10.10.10.148 | csgo / cs2 match 8 | match8
10.10.10.149 | csgo / cs2 match 9 | match9
10.10.10.150 | csgo / cs2 match 10 | match10
10.10.10.151 | csgo / cs2 match 11 | match11
10.10.10.152 | csgo / cs2 match 12 | match12

As we add more to this list, we'll keep this updated so it's easy to see at a high level view.