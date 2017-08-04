local enter_Marker = createMarker(1748.1999511719, -1461.1999511719, 13.5, "corona", 1, 48, 253, 1,255)
local exit_Marker = createMarker(1724.3000488281, -1455.1999511719, 25.89999961853, "corona", 1, 48, 253, 1,255)

local woman = createPed(76, 1745.2998046875, -1472.900390625, 26.200000762939)


addEventHandler("onMarkerHit", enter_Marker,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not isPedInVehicle(hitElement) then
			setElementPosition(hitElement, 1726, -1455.3000488281, 26.200000762939)
			setElementRotation(hitElement, 270, 0, 0)
		end
	end
end)

addEventHandler("onMarkerHit", exit_Marker,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not isPedInVehicle(hitElement) then
			setElementPosition(hitElement, 1748.1999511719, -1459.1999511719, 13.5)
		end
	end
end)





--- For Gui

addEventHandler("onElementClicked", getRootElement(),
function(button, state, element)
	if state == "down" and button == "left" then
		if source == woman then
			triggerClientEvent(element, "openInsuranceGui", element)
		end
	end
end)

addEvent("loadInsuranceList", true)
addEventHandler("loadInsuranceList", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM vehicles WHERE vehowner = '"..getPlayerName(source).."' AND insurance = '"..(1).."'")
		local result, num_rows = dbPoll(query, -1)
		if result and num_rows > 0 then
			for index, Spalte in pairs (result) do
				triggerClientEvent(source, "fillInsList", source, Spalte["ownerid"], getVehicleNameFromModel(Spalte["vehid"]))
			end
		else
			dbFree(query)
		end
	end
end)

addEvent("enterInsuranceVehicle", true)
addEventHandler("enterInsuranceVehicle", getRootElement(),
function(ownerID, vehName)
	if source == client then
		dbExec(handler, "UPDATE vehicles SET insurance = '"..(0).."' WHERE vehowner = '"..getPlayerName(source).."' AND ownerid = '"..ownerID.."'")
		outputChatBox("Du hast dein Fahrzeug "..vehName.." erfolgreich eingelöst\nEs steht nun unten bereit", source, 0, 255, 0)
		
		local query = dbQuery(handler, "SELECT * FROM vehicles WHERE vehowner = '"..getPlayerName(source).."'")
		local result = dbPoll(query, -1)
		if result and #result > 0 then
			local veh = createVehicle(result[1]["vehid"], 1758, -1483.4000244141, 13.800000190735, 0, 0, 260, result[1]["plate"])
				VehElement[veh] = veh
				setVehicleColor(veh, gettok(result[1]["color"], 1, string.byte("|")), gettok(result[1]["color"], 2, string.byte("|")), gettok(result[1]["color"], 3, string.byte("|")))
				setVehicleData(veh, "Besitzer", result[1]["vehowner"])
				setVehicleData(veh, "Fuel", result[1]["fuel"])
				setVehicleData(veh, "ID", result[1]["ownerid"])
				setVehicleData(veh, "SaveTy", result[1]["safety"])
				setVehicleOverrideLights(veh, 1)
				setVehicleLocked(veh, true)
				VehByName[string.lower("veh"..getVehicleData(veh, "Besitzer")..getVehicleData(veh, "ID"))] = veh
				warpPedIntoVehicle(source, veh, 0)
				triggerClientEvent(source, "noCollision", source, veh, 20000)
		else
			dbFree(query)
		end
	end
end)