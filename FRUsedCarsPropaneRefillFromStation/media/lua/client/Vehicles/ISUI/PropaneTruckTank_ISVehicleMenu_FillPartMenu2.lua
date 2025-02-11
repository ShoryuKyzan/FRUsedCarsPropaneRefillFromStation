if not PropaneTanker then PropaneTanker = {} end

if not PropaneTanker.old_ISVehicleMenu_FillPartMenu then
	PropaneTanker.old_ISVehicleMenu_FillPartMenu = ISVehicleMenu.FillPartMenu
end

function ISVehicleMenu.FillPartMenu(playerIndex, context, slice, vehicle)
	local playerObj = getSpecificPlayer(playerIndex);

	local propaneStation = ISVehiclePartMenu.getNearbyPropanePump(vehicle);
	if propaneStation and propaneStation:getModData()["fuelAmount"] > 0 then
		for i=1,vehicle:getPartCount() do
			local part = vehicle:getPartByIndex(i-1)		
			if part:isContainer() and part:getContainerContentType() == "Propane Storage" 
			and part:getContainerContentAmount() < part:getContainerCapacity() then
				if slice then
					slice:addSlice(getText("Fill Propane Storage Tank From Propane Station"), getTexture("Item_PropaneTank"), ISVehiclePartMenu.onPumpPropane, part, playerObj, propaneStation)
				else
					context:addOption(getText("Fill Propane Storage Tank From Propane Station"), part, ISVehiclePartMenu.onPumpPropane, playerObj, propaneStation);
				end
			end
		end			
	end
	PropaneTanker.old_ISVehicleMenu_FillPartMenu(playerIndex, context, slice, vehicle)
end


