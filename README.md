https://steamcommunity.com/sharedfiles/itemedittext/?id=3436239634

Workshop ID: 3436239634
Mod ID: FRUsedCarsPropaneRefillFromStation

# Build 41

# Filibuster Rhymes' Used Cars! Propane Truck/Tanks Refill

This mod for Project Zomboid extends Filibuster Rhymes Used Cars & TiRekS Propane Upgraded. Makes the trucks refillable from station and adds support for 2 more tank types for station or truck refill. See below for details.

## Features
* refilling propane trucks (Franklin EF70) from a propane station
* refilling Industrial Propane Tanks (LargePropaneTank) from the truck and station
* refilling Propane Storage Tanks (HugePropaneTank) from the truck
* use the vehicle menu or context menu to do these actions.

## Help
* For filling tanks from the truck, make sure they are in inventory/on ground/in a container next to you when you access the vehicle menu.
* The very back of the truck doesn't seem to want to show the radial menu. Use context menu, or walk to the side or the front of the truck to see the new options in the radial menu.
* Per online research of propane truck-filling, the station must have electricity to fill the truck. Electricity isn't required to fill smaller tanks though.

# Requirements/Server Load order
Subscribe and add these Mod IDs
* PropStation [TiRekS Propane Upgraded (PropStation)](https://steamcommunity.com/sharedfiles/filedetails/?id=2748628874&searchtext=tirek)
* FRUsedCarsFT [Filibuster Rhymes' Used Cars! Fuel Test (FRUsedCarsFT)](https://steamcommunity.com/sharedfiles/filedetails/?id=1510950729)
 (and other Filibuster Rhymes used cars mod ids required to activate this mod in the first place)
* FRUsedCarsPropaneRefillFromStation (this mod)
  * For servers, place this in the list after the other requirements

# Credits
This extends and uses inspiration from the following mods:
* [TiRekS Propane Upgraded (PropStation)](https://steamcommunity.com/sharedfiles/filedetails/?id=2748628874&searchtext=tirek)
* [Filibuster Rhymes' Used Cars! Fuel Test (FRUsedCarsFT)](https://steamcommunity.com/sharedfiles/filedetails/?id=1510950729)

# License
Free to use/modify/extend/bundle with other mods. Do not claim it as your own.
MIT License
No need to copy in the license file when using locally or on a server.

# Development Scripts

### Build

The `build.bat` script zips up the contents of the `FRUsedCarsPropaneRefillFromStation` folder into a zip file of the same name.

### Clean

The `clean.bat` script removes the local mod from the user profile's Zomboid\mods folder.

### Deploy

The `deploy.bat` script copies the local mod to the user profile's Zomboid\mods folder for testing.


### Deploy to Workshop folder

The `deploy-workshop.bat` script copies the local mod to the user profile's Zomboid\Workshop folder for upload. Copies the workshop.txt. This has a description that should be manually copied in from Workshop.bbcode when it needs to be updated.

