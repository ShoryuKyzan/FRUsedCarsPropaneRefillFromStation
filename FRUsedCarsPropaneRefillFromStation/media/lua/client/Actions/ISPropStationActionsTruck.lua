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
	
	-- XXX prolly not needed -- self.tank:setJobDelta(self:getJobDelta())
	-- XXX prolly not needed -- self.tank:setJobType(getText("ContextMenu_AddGas"))
	
	-- print("self:getJobDelta() " + tostring(self:getJobDelta())); -- XXX
	-- print("self.propStationTarget " + tostring(self.propStationTarget)); -- XXX
	-- print("self.propStationStart " + tostring(self.propStationStart)); -- XXX
	-- print("self.tankStart " + tostring(self.tankStart)); -- XXX
	-- print("self.tankTarget " + tostring(self.tankTarget)); -- XXX
	-- print("self.amountSent " + tostring(self.amountSent)); -- XXX
	local litres = self.propStationStart + (self.propStationStart - self.propStationTarget)*self:getJobDelta()
	litres = math.ceil(litres)
	
	if litres ~= self.amountSent then
		local Obj = self.propStation;
		local args = { x = Obj:getX(), y = Obj:getY(), z = Obj:getZ(), fuelAmount = litres }
		CPropStationSystem.instance:sendCommand(self.character, 'fuelChange', args)
		self.amountSent = litres
		-- XXX these might be needed, but need vehicle too.
		-- local args = { vehicle = self.vehicle:getId(), part = self.tank:getId(), amount = litres }
		-- sendClientCommand(self.character, 'vehicle', 'setContainerContentAmount', args)
	end

	
	local litresTaken = litres - self.propStationStart
	local newAmount = self.tankStart + litresTaken;
	-- print(self.propStationStart); -- XXX
	-- print(litresTaken); -- XXX this is negative.
	-- print(self.tankStart); -- XXX this doesnt change
	-- print(newAmount); -- XXX decreasing
	self.tank:setContainerContentAmount(newAmount)
end

function ISPropStationActionsTruck:start()
	self.propStationStart = self.propStation:getModData()["fuelAmount"]
	print(self.propStationStart); -- XXX
	self.tankStart = self.tank:getContainerContentAmount();
	
	local add = self.tank:getContainerCapacity() - self.tank:getContainerContentAmount();
	local take = math.min(add, self.propStationStart);
		
	self.propStationTarget = self.propStationStart - take;
	self.tankTarget = self.tankStart + take;
	
	self.amountSent = math.ceil(self.propStationStart);
	self.action:setTime(30 + take * 45)
end

function ISPropStationActionsTruck:stop()
	-- XXX prolly not needed -- self.tank:setJobDelta(0)
    ISBaseTimedAction.stop(self);
end

function ISPropStationActionsTruck:perform()
	-- XXX prolly not needed -- self.tank:setJobDelta(0)
	self.tank:setContainerContentAmount(self.tankTarget)
	local Obj = self.propStation;
	local args = { x = Obj:getX(), y = Obj:getY(), z = Obj:getZ(), fuelAmount = self.propStationTarget }
	CPropStationSystem.instance:sendCommand(self.character, 'fuelChange', args)
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPropStationActionsTruck:new(character, propStation, tank, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.propStation = propStation;
    --o.square = square;
	o.tank = tank;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	return o;
end
