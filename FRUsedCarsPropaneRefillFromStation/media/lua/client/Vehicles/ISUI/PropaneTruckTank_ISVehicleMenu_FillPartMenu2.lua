if not PropaneTanker then PropaneTanker = {} end

if not PropaneTanker.old_ISVehicleMenu_FillPartMenu then
	PropaneTanker.old_ISVehicleMenu_FillPartMenu = ISVehicleMenu.FillPartMenu
end


-- util func to add menu option for fill for a tank type
function PropaneTanker.addTankOption(playerObj, typeToItem, part, context, slice, type, typeClass, labelStr)
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
	if propaneStation and propaneStation:getModData()["fuelAmount"] > 0 then
		for i=1,vehicle:getPartCount() do
			local part = vehicle:getPartByIndex(i-1)		
			if part:isContainer() and part:getContainerContentType() == "Propane Storage" 
			and part:getContainerContentAmount() < part:getContainerCapacity() then
				if slice then
					slice:addSlice(getText("Fill Truck Propane Tank From Propane Station"), getTexture("Item_PropaneTank"), ISVehiclePartMenu.onPumpPropane, part, playerObj, vehicle, propaneStation)
				else
					context:addOption(getText("Fill Truck Propane Tank From Propane Station"), part, ISVehiclePartMenu.onPumpPropane, playerObj, vehicle, propaneStation);
				end
			end
		end			
	end


	for i=1,vehicle:getPartCount() do
		local part = vehicle:getPartByIndex(i-1)		
		if part:isContainer() and part:getContainerContentType() == "Propane Storage"
		and part:getContainerContentAmount() > 0 then
			PropaneTanker.addTankOption(playerObj, typeToItem, part, context, slice, "LargePropaneTank", "TW.LargePropaneTank", "(Industrial)")
			PropaneTanker.addTankOption(playerObj, typeToItem, part, context, slice, "HugePropaneTank", "TW.HugePropaneTank", "(Storage)")
		end			
	end

	PropaneTanker.old_ISVehicleMenu_FillPartMenu(playerIndex, context, slice, vehicle)
end

