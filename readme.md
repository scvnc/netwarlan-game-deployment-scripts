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
10.10.10.120 | cstrike snowsk337
10.10.10.121 | garrys mod - prop hunt
10.10.10.122 | tf2 casual
10.10.10.123 | tf2 mvm
10.10.10.124 | satisfactory
10.10.10.125 | ut2004
10.10.10.126 | l4d2
10.10.10.127 | rust | rust
10.10.10.128 | 
10.10.10.129 | connect | connect
10.10.10.130 | minecraft | minecraft
10.10.10.131 | cs2 casual 1
10.10.10.132 | cs2 casual 2
10.10.10.133 | cs2 scrim 1
10.10.10.134 | cs2 scrim 2
10.10.10.135 | 
10.10.10.136 |
10.10.10.137 |
10.10.10.138 | 
10.10.10.139 | 
10.10.10.140 | 
10.10.10.141 | cs2 match pro 1
10.10.10.142 | cs2 match pro 2
10.10.10.143 | cs2 match pro 3
10.10.10.144 | cs2 match pro 4
10.10.10.145 | cs2 match pro 5
10.10.10.146 | cs2 match pro 6
10.10.10.147 | cs2 match pro 7
10.10.10.148 | cs2 match pro 8
10.10.10.149 | cs2 match pro 9
10.10.10.150 | cs2 match pro 10
10.10.10.151 | cs2 match casual 1
10.10.10.152 | cs2 match casual 2
10.10.10.153 | cs2 match casual 3
10.10.10.154 | cs2 match casual 4
10.10.10.155 | cs2 match casual 5
10.10.10.156 | 
10.10.10.157 | 
10.10.10.158 | 
10.10.10.159 | 
10.10.10.160 | live
10.10.10.161 | click

### CPU Pinning Assignments
To help a bit with performance, we'll pin containers to specific core(s) and/or ranges. The following maps out those assignments:
Core # | Container / Server | Notes
------ | ------------------ | -----
0 | CStrike SnowSk337
1 | L4D2
2 | Live
3 | TF2 Casual
4 | TF2 MvM
5 | Satisfactory
6 | UT2004
7-11 | Rust
12 | Minecraft
13 | Garrys Mod
14 | CS2 Casual 1
15 | CS2 Casual 2
16 | CS2 Scrim 1
17 | CS2 Scrim 2
18 | CS2 Match Pro 1
19 | CS2 Match Pro 2
20 | CS2 Match Pro 3
21 | CS2 Match Pro 4
22 | CS2 Match Pro 5
23 | CS2 Match Pro 6
24 | CS2 Match Pro 7
25 | CS2 Match Pro 8
26 | CS2 Match Pro 9
27 | CS2 Match Pro 10
28 | CS2 Match Casual 1
29 | CS2 Match Casual 2
30 | CS2 Match Casual 3
31 | CS2 Match Casual 4
33 | CS2 Match Casual 5


As we add more to this list, we'll keep this updated so it's easy to see at a high level view.
