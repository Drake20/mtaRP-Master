addEventHandler("onElementDestroy", getRootElement(),
function()
	if getElementType(source) == "vehicle" then
		if VehElement[source] then
			VehElement[source] = nil
			VehByName[string.lower("veh"..getVehicleData(source, "Besitzer")..getVehicleData(source, "ID"))] = nil
		end
		if VehTable[source] then
			VehTable[source] = nil
		end
		if isTimer(TankTimer[source]) then
			killTimer(TankTimer[source])
			TankTimer[source] = nil
		end
	end
end)


PlayerElement = {}

function setPlayerElement(pElement, pString, pValue)
	if not PlayerElement[pElement] then
		PlayerElement[pElement] = {}
	end
	PlayerElement[pElement][pString] = pValue
end

function getPlayerElement(pElement, pString)
	if PlayerElement[pElement] == nil then
		return
	end
		return PlayerElement[pElement][pString]
end


addEventHandler("onPlayerQuit", getRootElement(),
function()
	if PlayerElement[source] then
		PlayerElement[source] = nil
	end
end)