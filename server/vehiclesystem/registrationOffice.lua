local enterMarker = createMarker(1451.8000488281, -2287, 13.39999961853, "corona", 1, 23, 254, 0 , 255)
local exitMarker = createMarker(846.29998779297, 53, 985, "corona", 1, 23, 254, 0 , 255)
local PickUp = createPickup(834.40002441406, 51.299999237061, 985.29998779297, 3, 1239, 1000)



local Ped = createPed(187, 832.20001220703, 51.099998474121, 985.29998779297, 270.001373, false)
setElementInterior(Ped, 3)
setElementInterior(exitMarker, 3)
setElementInterior(PickUp, 3)


addEventHandler("onMarkerHit", enterMarker,
function(player)
	if getElementType(player) == "player" then
		if not (getPedOccupiedVehicle(player)) then
			setPedRotation(player, 90)
			setElementInterior(player, 3, 844.59997558594, 53.200000762939, 985.29998779297)
		end
	end
end)

addEventHandler("onMarkerHit", exitMarker,
function(player)
	if getElementType(player) == "player" then
		if not (getPedOccupiedVehicle(player)) then
			setElementInterior(player, 0, 1447.0999755859, -2287, 13.5)
			setPedRotation(player, 90)
		end
	end
end)


addEventHandler("onPickupHit", PickUp,
function(player)
	if getElementType(player) == "player" then
		if not (getPedOccupiedVehicle(player)) then
			triggerClientEvent(player, "startOfficeWeb", player)
		end
	end
end)


addEvent("forVehIds", true)
addEventHandler("forVehIds", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM vehicles WHERE vehowner = '"..getPlayerName(source).."'")
		local result = dbPoll(query, -1)
		if result and #result > 0 then
			outputChatBox("Alle Fahrzeuge:", source, 0, 255, 0)
			for k,v in ipairs(result) do
				outputChatBox(getVehicleNameFromID(v["vehid"]).." Persönliche ID: "..v["ownerid"].." Preis: Platzhalter", source, 0, math.random(1, 255), 0)
			end
		else
			dbFree(query)
		end
	end
end)

addEvent("enterDBVehicleOffice", true)
addEventHandler("enterDBVehicleOffice", getRootElement(),
function(name, kennzeichen, id)	
	if source == client then
		local CheckQuery = dbQuery(handler, "SELECT * FROM vehicles WHERE ownerid = '"..id.."' AND vehowner = '"..name.."'")
		local CheckResult = dbPoll(CheckQuery, -1)
		if CheckResult and #CheckResult > 0 then
			if CheckResult[1]["activated"] == 1 then outputChatBox("Dein Fahrzeug ist bereits angemeldet", source, 255, 0, 0) return end
			local query = dbQuery(handler, "SELECT plate FROM vehicles WHERE plate = '"..kennzeichen.."'")
			local result = dbPoll(query, -1)
			if result then
				if #result == 0 then
					local var = 1
					dbExec(handler, "UPDATE vehicles SET activated = '"..var.."', plate = '"..kennzeichen.."' WHERE vehowner = '"..name.."' AND ownerid = '"..id.."'")
					setVehiclePlateText(VehByName[string.lower("veh"..name..id)], kennzeichen)
					outputChatBox("Dein Fahrzeug wurde erfolgreich angemeldet", source, 0, 255, 0)
					triggerClientEvent(source, "closeOfficeWindow", source)
				else
					outputChatBox("Das Kennzeichen wird bereits verwendet", source, 0, 255, 0)
				end
			else
				dbFree(query)
			end
		else
			dbFree(CheckQuery)
			outputChatBox("Du hast kein Fahrzeug mit dieser ID!", source, 255, 0, 0)
		end
	end
end)

addEvent("exitDBVehicleOffice", true)
addEventHandler("exitDBVehicleOffice", getRootElement(),
function(id)
	if source == client then	
		local query = dbQuery(handler, "SELECT activated FROM vehicles WHERE vehowner = '"..getPlayerName(source).."' AND ownerid = '"..id.."'")
		local result = dbPoll(query, -1)
		if result and #result > 0 then
			if result[1]["activated"] == 1 then
				local var = 0
				local var2 = " "
				dbExec(handler, "UPDATE vehicles SET activated = '"..var.."', plate = '"..var2.."' WHERE vehowner = '"..getPlayerName(source).."' AND ownerid = '"..id.."'")
				setVehiclePlateText(VehByName[string.lower("veh"..getPlayerName(source)..id)], " ")
				triggerClientEvent(source, "closeOfficeWindow", source)
				outputChatBox("Fahrzeug erfolgreich abgemeldet!", source, 0, 255, 0)
			else
				outputChatBox("Das Fahrzeug ist bereits abgemeldet!", source, 255, 0, 0)
			end
		else
			dbFree(query)
			outputChatBox("Dein Fahrzeug ist nicht vorhanden oder abgemeldet!", source, 255, 0, 0)
		end
	end
end)


addEvent("savetyDBVehicleOffice", true)
addEventHandler("savetyDBVehicleOffice", getRootElement(),
function(id)
	if source == client then
		local query = dbQuery(handler, "SELECT safety FROM vehicles WHERE vehowner = '"..getPlayerName(source).."' AND ownerid = '"..id.."'")
		local result = dbPoll(query, -1)
		if result and #result > 0 then
			if result[1]["safety"] == 0 then
				local var = 1
				dbExec(handler, "UPDATE vehicles SET safety = '"..var.."' WHERE vehowner = '"..getPlayerName(source).."' AND ownerid = '"..id.."'")
				setVehicleData(VehByName[string.lower("veh"..getPlayerName(source)..id)], "SaveTy", 1)
				triggerClientEvent(source, "closeOfficeWindow", source)
				outputChatBox("Du hast dein Fahrzeug erfolgreich versichert!", source, 0, 255, 0)
			else
				outputChatBox("Das Auto ist bereits versichert!", source, 255, 0, 0)
			end
		else
			outputChatBox("Das Fahrzeug ist nicht vorhanden!", source, 255, 0, 0)
		end
	end
end)