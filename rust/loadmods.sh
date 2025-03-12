mods=(
  ZoneManager.cs
  ZoneManagerAutoZones.cs
  ZoneDomes.cs
  TruePVE.cs
  BlueprintManager.cs
  GatherManager.cs
  Kits.cs
  BetterLoot.cs
)

for modfile in ${mods[@]}; do

  PLUGIN_URL=https://umod.org/plugins/${modfile}
  echo Downloading $PLUGIN_URL 
  curl -sL ${PLUGIN_URL} -o config/oxide/plugins/${modfile}
  
done

ls -1 config/oxide/plugins
