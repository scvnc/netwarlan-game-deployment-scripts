## Fixing the docker image

When the container is restarted, it [erases all the mod config files](https://github.com/netwarlan/rust/blob/63de613c2dfb69405924e17b34d409dcf69ed2b8/run.sh#L107) inside `data/oxide/data` and `data/oxide/config`.

If not fixed for netwar 45, we will have to take care to copy the files out of these folders and restore them before restarting the server. 

Some fix options

- A temporary fix may be have the deployment script build an image with a modified `run.sh`  [Here is a PR](https://github.com/netwarlan/game-deployment-scripts/pull/3)
- Modify/build the rust docker image to not clean up the oxide folder.




## Mods Guide/Notes

All of this can be performed after the server is running. No need to modify any docker/deploy config.

If a command starts with a forward slash, then it is something you type in chat.
Otherwise it should be typed in the game console (F1) or rcon.

### Add me as admin via rcon

`ownerid 76561197984485782 "_drone"`

### Verify that I am admin

Log in after granted admin via rcon

I know I am admin because I can invoke `server.writecfg` and it reports that the game config was written to disk.

### Install mods

Download (wget/curl) these mods to the `data/oxide/plugins/` folder

```
curl -sL https://umod.org/plugins/ZoneManager.cs -o ZoneManager.cs
curl -sL https://umod.org/plugins/ZoneDomes.cs -o ZoneDomes.cs
curl -sL https://umod.org/plugins/Kits.cs -o Kits.cs
```

The server will detect the files, compile, and launch each mod while it is runnning.

### Create a PvE zone on the map

Perhaps, after some exploring, we should find a nice place on the map where player and building damage is disabled.

    /zone_add
    /zone radius 100

You can fine tune the location to your current position with

    /zone location here

Now, lets turn on some flags with the UI to turn it into a PvE zone.

    /zone flags

Turn on `UnDestr` and `PvpGod` so that buildings are undestroyable and players can't hurt eachother.

Set the name and notifications of the zone

    /zone name "NETWAR Town"
    /zone enter_message "Welcome to NETWAR town! You are safe from player damage and raiding."
    /zone leave_message "You are leaving NETWAR town"

### Create a visual border around the PvE zone we just created

Now that you've set up the zone, you can make a visual border around it.

First, while you are in the zone you just made, find the ZoneID from the `/zone` command

Now that you have the zone id, make a green border around the zone. (3 is for green)

    /zd add zone_id 3


## Setting up kits

At some point in the lifecycle of the event, we may want to offer some kits so that new 
players don't have to grind for a weapon or tools. Maybe something basic. This mod provides 
a nice UI "shop" that allows the player to get a set of items (with optional cooldown.)

### Grant permission to admin the kits mod

`oxide.grant user _drone kits.admin`

### Launch the kits ui

Should be mostly self explanatory expecially with their UI and docs.


    /kit
    /kit new

## Gather
We can see if the gather mod is working and check its params with 

    /gather

## Plants

Perhaps at some point, increasing the rate at which plants grow would be useful.
I read adjusting the tick scale is a good idea to do this.  Example making it 2x:

    server.planttickscale 2
