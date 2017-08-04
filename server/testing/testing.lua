vehicle = {

create = createVehicle,
Lock = setVehicleLocked
}

vehicle.create(495, 642, -561, 17, 0, 0, 0)


police = {}
police.__index = police


function police:Constructor()

	local init = {}
	setmetatable(init, self)
	init.__index = self
	init.name = name
	init.members = {}

	return init
end


function police:addMember(spieler , fraktion)
	table.insert(self.members, spieler)
end

function police:removeMember(player)
	local e = false
	for k, v in ipairs (self.members) do
		if v == player then
			table.remove(self.members, k)
			e = true
		end
	end
		return e
end



function police:memberCount()
	return #self.members
end