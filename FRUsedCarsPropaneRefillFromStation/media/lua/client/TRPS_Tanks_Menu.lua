TRPS_Tanks_Menu={}

TRPS_Tanks_Menu.doMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end
	
	local MyhaveFuel = nil;
	local tank = nil;
	
	for i,v in ipairs(worldobjects) do
		if CPropStationSystem.instance:isValidIsoObject(v) and CPropStationSystem:isValidPart(v:getModData()["partSquare"]) then
			MyhaveFuel = v
		end
	end
	
    -- Allow refilling Industrial Propane Tanks
    if MyhaveFuel and MyhaveFuel:getModData()["fuelAmount"] > 0 then
		if test == true then return true; end	
		local propaneTanks = getSpecificPlayer(player):getInventory():getItemsFromType("LargePropaneTank");
		
        for i=0, propaneTanks:size() -1 do
            if propaneTanks:get(i):getUsedDelta() < 1 then
                tank = propaneTanks:get(i);
                break;
            end
		end
		
		if tank then
			context:addOption(getText("Refill Large Propane Tank"), tank, TRPS_Menu.onTakeFuel, getSpecificPlayer(player), MyhaveFuel);
		end
    end
	
end

Events.OnFillWorldObjectContextMenu.Add(TRPS_Tanks_Menu.doMenu);
