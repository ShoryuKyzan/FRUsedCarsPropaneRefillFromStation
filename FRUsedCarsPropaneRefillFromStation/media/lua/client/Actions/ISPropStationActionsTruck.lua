--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPropStationActionsTruck = ISBaseTimedAction:derive("ISPropStationActionsTruckTruck");

function ISPropStationActionsTruck:isValid()
	return true;
end

function ISPropStationActionsTruck:update()
	self.character:faceLocation(self.propStation:getSquare():getX(), self.propStation:getSquare():getY())
	
	local litres = self.propStationStart + (self.propStationTarget - self.propStationStart)*self:getJobDelta()
	litres = math.ceil(litres)
	
	if litres ~= self.amountSent then
		local Obj = self.propStation;
		local args = { x = Obj:getX(), y = Obj:getY(), z = Obj:getZ(), fuelAmount = litres }
		CPropStationSystem.instance:sendCommand(self.character, 'fuelChange', args)
		self.amountSent = litres
	end

	
	local litresTaken = (litres - self.propStationStart) * -1
	local newAmount = self.tankStart + litresTaken;
	local args2 = { vehicle = self.vehicle:getId(), part = self.tank:getId(), amount = newAmount }
	sendClientCommand(self.character, 'vehicle', 'setContainerContentAmount', args2)
	-- XXX might not need - self.tank:setContainerContentAmount(newAmount)
end

function ISPropStationActionsTruck:start()
	self.propStationStart = self.propStation:getModData()["fuelAmount"]
	self.tankStart = self.tank:getContainerContentAmount();
	
	local add = self.tank:getContainerCapacity() - self.tank:getContainerContentAmount();
	local take = math.min(add, self.propStationStart);
		
	self.propStationTarget = self.propStationStart - take;
	self.tankTarget = self.tankStart + take;
	
	self.amountSent = math.ceil(self.propStationStart);
	self.action:setTime(30 + take * 45)
end

function ISPropStationActionsTruck:stop()
    ISBaseTimedAction.stop(self);
end

function ISPropStationActionsTruck:perform()
	self.tank:setContainerContentAmount(self.tankTarget)
	local Obj = self.propStation;
	local args = { x = Obj:getX(), y = Obj:getY(), z = Obj:getZ(), fuelAmount = self.propStationTarget }
	CPropStationSystem.instance:sendCommand(self.character, 'fuelChange', args)
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPropStationActionsTruck:new(character, vehicle, propStation, tank, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.vehicle = vehicle;
	o.propStation = propStation;
    --o.square = square;
	o.tank = tank;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	return o;
end
