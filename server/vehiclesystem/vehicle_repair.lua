local RepairColor = {}

setGarageOpen(10, true) -- Transfender Garage Los Santos
setGarageOpen(7, true) -- Lowrider Garage LS

local dim = 0

local Transfender_MarkerLS = createMarker(1041.6999511719, -1018.799987793, 31, "cylinder", 5, 36, 254, 0, 255)

local SP_LowRider_MarkerLS = createMarker(2645, -2042.8000488281, 11.699999809265, "cylinder", 4, 36, 254, 0, 255)
local var1;

addEventHandler("onMarkerHit", Transfender_MarkerLS,
function(hitElement)
	if getElementType(hitElement) == "vehicle" then
		if getVehicleOccupant(hitElement) then
			dim = dim+1
			local driver = getVehicleOccupant(hitElement)
			local r, g, b, r2, g2, b2 = getVehicleColor(hitElement)
				RepairColor[hitElement] = {
					[1] = r,
					[2] = g,
					[3] = b,
					[4] = r2,
					[5] = g2,
					[6] = b2,
				}
			setElementInterior(hitElement, 3, 614.20001220703, -124.59999847412, 998.09997558594)
			setElementInterior(driver, 3)
			setElementDimension(hitElement, dim)
			setElementDimension(driver, dim)
			setCameraMatrix(driver, 609.2421875, -118.9423828125, 1000.5704956055, 680.802734375, -181.9765625, 970.47210693359)
			toggleAllControls(driver, false)
			setElementRotation(hitElement, 0, 0, 90)
				if not (getVehicleData(hitElement, "Besitzer") == nil) then
					if getVehicleData(hitElement, "Besitzer") == getPlayerName(driver) then
						outputChatBox("JO")
						var1 = 1
					else
						outputChatBox("NO2")
						var1 = 0
					end
				else
					outputChatBox("NO")
					var1 = 0
				end
			triggerClientEvent(driver, "startRepairWeb", driver, 2, var1)
			setTimer(
			function(hitElement)
				setElementFrozen(hitElement, true)
			end, 1000, 1, hitElement)
		end
	end
end)

addEventHandler("onMarkerHit", SP_LowRider_MarkerLS,
function(hitElement)
	if getElementType(hitElement) == "vehicle" then
		if getVehicleOccupant(hitElement) then
			dim = dim+1
			local driver = getVehicleOccupant(hitElement)
			local r, g, b, r2, g2, b2 = getVehicleColor(hitElement)
				RepairColor[hitElement] = {
					[1] = r,
					[2] = g,
					[3] = b,
					[4] = r2,
					[5] = g2,
					[6] = b2,
				}
			setElementInterior(hitElement, 3, 614.20001220703, -124.59999847412, 998.09997558594)
			setElementInterior(driver, 3)
			setElementDimension(hitElement, dim)
			setElementDimension(driver, dim)
			setCameraMatrix(driver, 609.2421875, -118.9423828125, 1000.5704956055, 680.802734375, -181.9765625, 970.47210693359)
			toggleAllControls(driver, false)
			setElementRotation(hitElement, 0, 0, 90)
			setTimer(
			function(hitElement)
				setElementFrozen(hitElement, true)
			end, 1000, 1, hitElement)
				if not (getVehicleData(hitElement, "Besitzer") == nil) and getVehicleData(hitElement, "Besitzer") == getPlayerName(driver) then
					var1 = 1
				elseif getVehicleData(hitElement, "Besitzer") == nil or getVehicleData(hitElement, "Besitzer") ~= getPlayerName(driver) then
					var1 = 0
				end
			triggerClientEvent(driver, "startRepairWeb", driver, 1, var1)
		end
	end
end)

addEvent("repairVehicleFromWeb", true)
addEventHandler("repairVehicleFromWeb", getRootElement(),
function()
	if source == client then
		fixVehicle(getPedOccupiedVehicle(source))
		outputChatBox("Dein Fahrzeug wurde repariert!", source, 0, 255, 0)
	end
end)

addEvent("ServerLack1Vehicle", true)
addEventHandler("ServerLack1Vehicle", getRootElement(),
function(r, g, b, r2, g2, b2)
	if source == client then
		setVehicleColor(getPedOccupiedVehicle(source), r, g, b, r2, g2, b2)
	end
end)

addEvent("buyVehiclePaint", true)
addEventHandler("buyVehiclePaint", getRootElement(),
function(r, g, b, r2, g2, b2)
	if source == client then
		local query = dbQuery(handler, "SELECT ownerid FROM vehicles WHERE vehowner = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		if result and #result > 0 then
			if result[1] == getVehicleData(getPedOccupiedVehicle(source), "ID") then
			dbExec(handler, "UPDATE vehicles SET color = ? WHERE vehowner = ?;", "|"..r.."|"..g.."|"..b.."|", getPlayerName(source))
			setVehicleColor(getPedOccupiedVehicle(source), r, g, b, r2, g2, b2)
			RepairColor[hitElement] = {
					[1] = r,
					[2] = g,
					[3] = b,
					[4] = r2,
					[5] = g2,
					[6] = b2,
				}
			else 
				outputChatBox("Das ist nicht dein Auto!", source, 255, 0, 0)
			end
		else
			dbFree(query)
		end
	end
end)

addEvent("removePedFromRepairRoom", true)
addEventHandler("removePedFromRepairRoom", getRootElement(),
function(repair)
	if source == client then
		setElementDimension(source, 0)
		setElementInterior(source, 0)
		setElementDimension(getPedOccupiedVehicle(source), 0)
		setElementInterior(getPedOccupiedVehicle(source), 0)
		setCameraTarget(source, source)
		toggleAllControls(source, true)
		setElementFrozen(getPedOccupiedVehicle(source), false)
		if RepairColor[getPedOccupiedVehicle(source)] then
			local vehicle = getPedOccupiedVehicle(source)
			setVehicleColor(vehicle, RepairColor[vehicle][1], RepairColor[vehicle][2], RepairColor[vehicle][3], RepairColor[vehicle][4], RepairColor[vehicle][5], RepairColor[vehicle][6])
			RepairColor[vehicle] = nil
		end
		if repair == 1 then
			setElementPosition(getPedOccupiedVehicle(source), 2653.8999023438, -2007.5, 13.5)
			setElementRotation(getPedOccupiedVehicle(source), 0, 0, 270)
		elseif repair == 2 then
			setElementPosition(getPedOccupiedVehicle(source), 1045.0999755859, -1045.1999511719, 31.799999237061)
			setElementRotation(getPedOccupiedVehicle(source), 0, 0, 270)
		end
	end
end)