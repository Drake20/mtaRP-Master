local couttAndSchutzEnter = createMarker(2131.8000488281, -1151.5999755859, 23.799999237061, "corona", 1, 53, 254, 0, 255)
local SchutzVehicles = {495, 405, 499}

addEventHandler("onMarkerHit", couttAndSchutzEnter,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not (isPedInVehicle(hitElement)) then
			triggerClientEvent(hitElement, "spawnVehForSchutz", hitElement)
			triggerClientEvent(hitElement, "startvehHouseBrowserWeb", hitElement)
			for k, v in ipairs (SchutzVehicles) do 
				triggerClientEvent(hitElement, "fillVehHouseBox", hitElement, getVehicleNameFromModel(v))
			end
		end
	end
end)


addCommandHandler("tpA",
function(player)
setElementPosition(player, 2135.08, -1141.24, 25.19)
end)



