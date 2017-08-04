addEventHandler("onElementClicked", getRootElement(),
function(mouse, state, player)
	if mouse == "right" and state == "down" and getElementType(source) == "vehicle" then
		if getVehicleData(source, "Besitzer") == nil then return end
			if string.lower(getVehicleData(source, "Besitzer")) == string.lower(getPlayerName(player)) then
				triggerClientEvent(player, "createNewWindow", player, "vehInteract", nil, nil, 300, 90, true, "http://mta/general/client/vehiclesystem/vehInteract.html", nil, false, script1, script2, script3, script4)
			end
	end
end)

local count = {}
local shape = {}

addEvent("selectPlayersInRadius", true)
addEventHandler("selectPlayersInRadius", getRootElement(),
function()
	if source == client then
		local x, y, z = getElementPosition(source)
		shape[source] = createColSphere(x, y, z, 15)
		for k, v in ipairs(getElementsByType("player")) do
			if isElementWithinColShape (v, shape[source]) then
				if not (v == source) then
					count[source] = 1
					triggerClientEvent(source, "insertPlayersIntoWeb", source, getPlayerName(v))
				end
			end
		end
		if not (count[source] == 1) then
			triggerClientEvent(source, "insertPlayersIntoWeb", source, "Kein Spieler in der nähe")
		end
		count[source] = nil
		destroyElement(shape[source])
	end
end)