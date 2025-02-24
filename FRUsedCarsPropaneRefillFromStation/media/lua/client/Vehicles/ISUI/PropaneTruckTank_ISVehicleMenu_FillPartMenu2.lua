if not TRPS_FillPartMenu then TRPS_FillPartMenu = {} end

if not TRPS_FillPartMenu.old_ISVehicleMenu_FillPartMenu then
	TRPS_FillPartMenu.old_ISVehicleMenu_FillPartMenu = ISVehicleMenu.FillPartMenu
end


-- util func to add menu option for fill for a tank type
-- does not physically move the tank when refilling. Intended for large immovable tanks
function TRPS_FillPartMenu.addTankOption(playerObj, typeToItem, part, context, slice, type, typeClass, labelStr)
	if PRFS_VehiclePartMenu.getPropaneTankNotFull(playerObj, typeToItem, type, typeClass) then
		if slice then
			slice:addSlice(getText("Refill " .. labelStr .. " From Propane Storage Tank"), getTexture("Item_PropaneTank"), PRFS_VehiclePartMenu.onTakePropane, playerObj, part, type, typeClass)
		else
			context:addOption(getText("Refill " .. labelStr .. " From Propane Storage Tank"), playerObj, PRFS_VehiclePartMenu.onTakePropane, part, type, typeClass)
		end
	end
end

function ISVehicleMenu.FillPartMenu(playerIndex, context, slice, vehicle)
	local playerObj = getSpecificPlayer(playerIndex);
	local typeToItem = VehicleUtils.getItems(playerObj:getPlayerNum())

	local propaneStation = ISVehiclePartMenu.getNearbyPropanePump(vehicle);
	
	for i=1,vehicle:getPartCount() do
		local part = vehicle:getPartByIndex(i-1)		
		if part:isContainer() and part:getContainerContentType() == "Propane Storage"  then
			if propaneStation and propaneStation:getModData()["fuelAmount"] > 0
			and part:getContainerContentAmount() < part:getContainerCapacity() then
				if slice then
					slice:addSlice(getText("Fill Truck Propane Tank From Propane Station"), getTexture("Item_PropaneTank"), ISVehiclePartMenu.onPumpPropane, part, playerObj, vehicle, propaneStation)
				else
					context:addOption(getText("Fill Truck Propane Tank From Propane Station"), part, ISVehiclePartMenu.onPumpPropane, playerObj, vehicle, propaneStation);
				end
			end
			TRPS_FillPartMenu.addTankOption(playerObj, typeToItem, part, context, slice, "LargePropaneTank", "TW.LargePropaneTank", "(Industrial)")
			TRPS_FillPartMenu.addTankOption(playerObj, typeToItem, part, context, slice, "HugePropaneTank", "TW.HugePropaneTank", "(Storage)")
		end
	end

	TRPS_FillPartMenu.old_ISVehicleMenu_FillPartMenu(playerIndex, context, slice, vehicle)
end

