# Filibuster Rhymes' Used Cars! Propane Truck/Tanks Refill

This project provides a mod for Project Zomboid that extends Filibuster Rhymes Used Cars & TiRekS Propane Upgraded.
## Features
* refilling propane trucks (Franklin EF70) from a propane station
* refilling Industrial Propane Tanks (LargePropaneTank) from the truck and station
* refilling Propane Storage Tanks (HugePropaneTank) from the truck when in inventory
  * TODO: this might not be an item that can be kept in the inventory, so maybe need it to be ground placeable

# Requirements
Subscribe and add these Mod IDs
* PropStation [TiRekS Propane Upgraded (PropStation)](https://steamcommunity.com/sharedfiles/filedetails/?id=2748628874&searchtext=tirek)
* FRUsedCarsFT [Filibuster Rhymes' Used Cars! Fuel Test (FRUsedCarsFT)](https://steamcommunity.com/sharedfiles/filedetails/?id=1510950729)
 (and other Filibuster Rhymes used cars mod ids required to activate this mod in the first place)
* FRUsedCarsPropaneRefillFromStation (this mod)

# Credits
This extends and uses inspiration from the following mods:
* [TiRekS Propane Upgraded (PropStation)](https://steamcommunity.com/sharedfiles/filedetails/?id=2748628874&searchtext=tirek)
* [Filibuster Rhymes' Used Cars! Fuel Test (FRUsedCarsFT)](https://steamcommunity.com/sharedfiles/filedetails/?id=1510950729)


# Development Scripts

### Build

The `build.bat` script zips up the contents of the `FRUsedCarsPropaneRefillFromStation` folder into a zip file of the same name.

### Clean

The `clean.bat` script removes the local mod from the user profile's Zomboid\mods folder.

### Deploy

The `deploy.bat` script copies the local mod to the user profile's Zomboid\mods folder for testing.

