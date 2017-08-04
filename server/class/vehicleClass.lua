function createNewVehicle(vehId, x, y, z, rx, ry, rz, plate, r, g, b, name, fuell, breakState, locked, noCollision)
	local id = 1
	local query = dbQuery(handler, "SELECT ownerid FROM vehicles WHERE vehowner = ?;", name)
	local result = dbPoll(query, -1)
	if result	then
		if #result > 0 	then
			for k, v in ipairs (result) do
				if not (v["ownerid"] == id) then
					break
				end
				id = id+1
			end
		end
			dbExec(handler, "INSERT INTO vehicles (vehid, vehowner, fuel, ownerid, activated, plate, safety, insurance, x, y, z, rx, ry, rz, color) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", vehId, string.lower(name), fuell, id, 0, plate, 0, 0, x, y, z, rx, ry, rz, "|"..r.."|"..g.."|"..b.."|")
			local veh = createVehicle(vehId, x, y, z, rx, ry, rz, plate)
			VehElement[veh] = veh
			setVehicleColor(veh, r, g, b)
			setVehicleData(veh, "Besitzer", string.lower(name))
			setVehicleData(veh, "Fuel", fuell)
			setVehicleData(veh, "ID", id)
			setVehicleData(veh, "SaveTy", 0)
			setVehicleOverrideLights(veh, 1)
			setVehicleLocked(veh, locked)
			setVehicleFrozen(veh, breakState)
			VehByName[string.lower("veh"..getVehicleData(veh, "Besitzer")..getVehicleData(veh, "ID"))] = veh
			if noCollision == true then
				triggerClientEvent(getPlayerFromName(name), "noCollision", getPlayerFromName(name), veh, 20000)
			elseif noCollision == nil then
				
			end
			id = 1
	else
		dbFree(query)
	end
end


addCommandHandler("gui",
function(player)
	triggerClientEvent(player, "createNewWindow", player, "gunther", 100, 100, 200, 200, "http://youtube.com", false)
	outputChatBox("jo", player, 0, 255, 0)
end)