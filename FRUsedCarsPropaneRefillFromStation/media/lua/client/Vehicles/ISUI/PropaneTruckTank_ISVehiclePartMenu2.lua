--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************
require "Vehicle/ISVehiclePartMenu"

if not PRFS_VehiclePartMenu then PRFS_VehiclePartMenu = {} end

function ISVehiclePartMenu.onPumpPropane(tank, player, vehicle, propStation)
	if tank and luautils.walkAdj(player, propStation:getSquare())  then	
		-- if luautils.haveToBeTransfered(player, tank) then
			-- ISTimedActionQueue.add(ISInventoryTransferAction:new(player, tank, tank:getContainer(), player:getInventory()));
		-- end
		ISTimedActionQueue.add(
			ISPropStationActionsTruck:new(
				player,
				vehicle, 
				propStation, 
				tank, 
				(tank:getContainerCapacity() - tank:getContainerContentAmount()) * 300
			)
		);
	end
end

function ISVehiclePartMenu.getNearbyPropanePump(vehicle)
	local part = vehicle:getPartById("500PropaneTruckTank")
	if not part then return nil end
	local areaCenter = vehicle:getAreaCenter(part:getArea())
	if not areaCenter then return nil end
	local square = getCell():getGridSquare(areaCenter:getX(), areaCenter:getY(), vehicle:getZ())
	if not square then return nil end

	local obj = nil;
	for dy=-2,2 do
		for dx=-2,2 do
			-- TODO: check line-of-sight between 2 squares
			local square2 = getCell():getGridSquare(square:getX() + dx, square:getY() + dy, square:getZ())
			for i=0, square2:getObjects():size()-1 do
				obj = square2:getObjects():get(i);
				if CPropStationSystem.instance:isValidIsoObject(obj) and CPropStationSystem:isValidPart(obj:getModData()["partSquare"]) then
					local square3 = obj:getSquare();
					if square3 and ((SandboxVars.AllowExteriorGenerator and square3:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
						return obj
					end
				end
			end
		end
	end
end

function PRFS_VehiclePartMenu.getPropaneTankNotFull(playerObj, typeToItem, type, typeClass)
	local equipped = playerObj:getPrimaryHandItem()
	
	if equipped and equipped:getType() == type and equipped:getUsedDelta() < 1 then
		return equipped
	end
	
	if typeToItem[typeClass] then
		local gasCan = nil
		local usedDelta = -1
		for _,item in ipairs(typeToItem[typeClass]) do
			if item:getUsedDelta() < 1 and item:getUsedDelta() > usedDelta then
				gasCan = item
				usedDelta = gasCan:getUsedDelta()
			end
		end
		if gasCan then return gasCan end
	end
		
	return nil
end


-- does not physically move the tank. intended for tanks on the ground or in a nearby container
function PRFS_VehiclePartMenu.onTakePropane(playerObj, part, type, typeClass)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	local typeToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
	local item = PRFS_VehiclePartMenu.getPropaneTankNotFull(playerObj, typeToItem, type, typeClass)
	if item then
		ISTimedActionQueue.add(ISTakeGasolineFromVehicle:new(playerObj, part, item, 50))
	end
end
