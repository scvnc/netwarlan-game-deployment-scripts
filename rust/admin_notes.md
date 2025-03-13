# Rust administration notes

`_drone`'s notes while exploring rust server administration for NETWAR.

Very significantly, it seems like the mods can be configured and reloaded while the server is running.  This should aleviate a lot of server reboots.

## The poormans way to bootstrap this fresh...

  `./rust.sh start`

watch the logs and wait for it to install oxide... then stop the server

  `./rust.sh stop`

While its off, load the saved mods/config by running

   `./rust.sh loadconfig`

and then you can start the server.

Later, after you are done tweaking the server and want to save the configs.. you can save it with

   `./rust.sh saveconfig`

This will save relevant config files to a git clone of `netwarlan/server-configs`.
From there, you can examine the diff and commit.

## Important Directories

- `data/server/rust/cfg/*` - server config files
- `data/oxide/plugins/*` - mods that will be loaded
- `data/oxide/config/*` - each mod seemingly has a json config and they are saved here

## Remote console (RCON)

You can run server admin commands in game via F1 console... or or connect to it through remote console (rcon).

There is a client-side web app that connects to the websocket the rust server exposes.

1. go to http://rcon.io/login
	- Run it on HTTP and not HTTPS.  I think this is because the websocket is not secure and browsers now flag this as deceptively insecure over https. 
2. type in the server ip, port (28016), and password
3. connect

### Troubleshooting

#### Browser complains about the connection not being secure

You may have to greenlist the domain in the browser settings per this [github issue. ](https://github.com/Facepunch/webrcon/issues/36) Likely easier with the chromium/edge browser.

If that doesn't work, try using the [facepunch reference client](http://facepunch.github.io/webrcon/), which isn't as nice as rcon.io, but could get you going.


## Setting up admins on the server

There are two baked in admin roles that are essentially the same for vanilla rust, but may differ in access for mods.

1. `owner` – This is an admin role that allows the creation and deletion of other admins.
2. `moderator` – This is an admin without the ability to create and delete other admins.

### Add via rcon

1. [Find the `steamID64`](https://steamid.io/) of the player you would like to grant admin access to.

2. Run the following rcon command with appropriate params
	- `ownerid steamID64 optional_user_name “optional_reason”`
		- replace `ownerid` with `moderatorid` for the corresponding role
	- Params
		- `optional_user_name` just set it to their last known steam display name
		- `optional_reason` could leave this as some default value, but you can comment who they are and why tehy should have it 
3. Persist the config with rcon cmd: `server.writecfg`

### Further reading
https://www.corrosionhour.com/add-rust-admins/

## Mods

### Notes

There is a mod manager "oxide" that is installed via flag. 

It seems like it is very easy to hotload mods.  It's observed when add/remove a mod file into the `oxide/plugins` folder, the server hot load/unloads the mod.

### Installed Mods

These are the mods I've played with while learning about this server.

- [TruePvE][TruePvE]
	- Allows one to set up PvE rules with particular zones of the map.
	- note: [purge mode](https://umod.org/community/true-pve/24865-perfect-truepve-settings-with-option-for-purge)

- [Dynamic PvP](https://umod.org/plugins/dynamic-pvp)
	- Enables zones on the map that allow PvP.  Works alongside [TruePvE][TruePvE].
	- PvP zones can be created around NPC events, like airdrops, destruction of patrol helicoptor, crate hacking, etc.
	- Monuments config.

- [ZoneDomes](https://umod.org/plugins/zone-domes)
	- Creates a visual dome around zones so that players know they are entering.
	- This may not be needed as Dynamic PvP already does this?
	
- [Rust Kits][Rust Kits]
	- Grant players premade kits to add to their inventory.
	- There can be a cooldown/purchase-costs to prevent abuse
	- has an admin ui, need to grant admin to particular players

- [GatherManager](https://umod.org/plugins/gather-manager)
	- This mod can speed up resource gathering
	- You can modify params at runtime with RCON!
	- This does not manage loot tables for barrels.
	- [Further reading](https://www.gameserverkings.com/knowledge-base/rust/modify-gather-rate/)

- [BlueprintManager](https://umod.org/plugins/blueprint-manager)
	- Brought over from prior netwar

[TruePvE]: https://umod.org/plugins/true-pve
[Rust Kits]:https://umod.org/plugins/rust-kits

### Mods to investigate

- BetterLootTables
	- TODO: make more scrap in barrels.

- Stretch goals
	- [Sign Artist Mod](https://rustez.com/forums/topic/4349-the-ultimate-sil-guide/ "https://rustez.com/forums/topic/4349-the-ultimate-sil-guide/") .. requires system libs to be installed.. save for later.

### 10x GatherManager rcon recipe

```
gather.rate dispenser * 10
gather.rate pickup * 10
gather.rate quarry * 10
gather.rate survey * 10
dispenser.scale tree 10
dispenser.scale ore 10
dispenser.scale corpse 10
server.writecfg
```


## Console cheat sheet

These should work in-game and also with rcon.  Most commands seem to provide console output. Invalid commands seem to do nothing.

### Graceful shutdown and restart

shutdown: `quit`
restart: `restart num_seconds`
### Persist server config

`server.writecfg` 

Saves any in-memory to the filesystem.  Seems to includes the configs of oxide plugins, but maybe not all of them.

### Spawning items to inventory

Refer to the [item list](https://www.corrosionhour.com/rust-item-list/)
#### Give item to yourself

`inventory.give short_name amount`
#### Give item to everyone that is logged in

`inventory.giveall short_name amount`
#### Give item to a particular player

`inventory.giveto player_name short_name amount`

#### More details 
[https://www.corrosionhour.com/rust-give-command/](https://www.corrosionhour.com/rust-give-command/ "https://www.corrosionhour.com/rust-give-command/") 

### Mod management

read [Oxide Commands](https://docs.oxidemod.com/guides/owners/commands#oxide-commands)

- `oxide.reload PluginName`: This command will unload and then load the specified plugin. This is useful when you have updated a plugin's configuration and need the changes to take effect.
- `oxide.load PluginName`: This command will load the specified plugin if it's not already loaded.
- `oxide.unload PluginName`: This command will unload the specified plugin.

## Notes


### Which mod to use, DynamicPvP, auto zone plugin?

Both?  Not sure yet.

dynamic pvp vs the auto zone plugin how to make a thing now? 

### It is ambiguous whether `serverauto.cfg` is used

There is written a `serverauto.cfg` and a `server.cfg`

note: https://oxidemod.org/threads/what-can-we-put-in-the-serverauto-cfg-file.11750/


## TODO

- How do we get it so that when we load the server, it doesn't recreate the map?
	- Test that we can shut down the server and relaunch it.
- Need to go through and config PvE / PvP
	- how do we turn off PvE and go full purge?
	- how do we create a zone on the map that is king of the hill?
- How do we spawn more nodes on the map (in case we run out?)
- Need to set kit admins for the UI



