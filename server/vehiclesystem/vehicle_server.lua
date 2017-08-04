VehElement = {}
VehByName = {}
VehTable = {}

function setVehicleData(vElement, vString, vValue)
	if not VehTable[vElement] then
		VehTable[vElement] = {}
	end
	VehTable[vElement][vString] = vValue
end

function getVehicleData(vElement, vString)
	if VehTable[vElement] == nil then
		return
	end
		return VehTable[vElement][vString]
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	local query = dbQuery(handler, "SELECT * FROM vehicles")
	local result = dbPoll(query, -1)
	if result and #result > 0 then
		for k, v in pairs (result) do
			if v["insurance"] == 0 then
				local veh = createVehicle(v["vehid"], v["x"], v["y"], v["z"], v["rx"], v["ry"], v["rz"], v["plate"])
				VehElement[veh] = veh
				setVehicleColor(veh, gettok(v["color"], 1, string.byte("|")), gettok(v["color"], 2, string.byte("|")), gettok(v["color"], 3, string.byte("|")))
				setVehicleData(veh, "Besitzer", string.lower(v["vehowner"]))
				setVehicleData(veh, "Fuel", v["fuel"])
				setVehicleData(veh, "ID", v["ownerid"])
				setVehicleData(veh, "SaveTy", v["safety"])
				setVehicleOverrideLights(veh, 1)
				setVehicleLocked(veh, true)
				setVehicleFrozen(veh, true)
				VehByName[string.lower("veh"..getVehicleData(veh, "Besitzer")..getVehicleData(veh, "ID"))] = veh
			end
		end
	else
		dbFree(query)
	end
end)

addEventHandler("onElementClicked", getRootElement(),
function(button, state, player)
	if button == "left" and state == "down" and getElementType(source) == "vehicle" then
		if getPlayerElement(player, "cursor") == false then return end
		if getVehicleData(source, "Besitzer") == nil then return end
		if string.lower(getVehicleData(source, "Besitzer")) == string.lower(getPlayerName(player)) then
			if isVehicleLocked(source) == true then
				triggerClientEvent(player, "startLockedSound", player)
				setVehicleLocked(source, false)
				outputChatBox("Fahrzeug aufgeschlossen!", player, 0, 255, 0)
			elseif isVehicleLocked(source) == false then
				setVehicleLocked(source, true)
				triggerClientEvent(player, "startLockedSound", player)
				outputChatBox("Fahrzeug abgeschlossen!", player, 0, 255, 0)
			end
			showCursor(player, false)
		end
	end
end)

addCommandHandler("park", 
function(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if string.lower(getVehicleData(veh, "Besitzer")) == string.lower(getPlayerName(player)) then
			if getElementVelocity(veh) == 0 then
				local x, y, z = getElementPosition(veh)
				local rx, ry, rz = getElementRotation(veh)
				--getElementRadius
				dbExec(handler, "UPDATE vehicles SET x = '"..x.."', y = '"..y.."', z = '"..z.."', rx = '"..rx.."', ry = '"..ry.."', rz = '"..rz.."' WHERE vehowner = '"..getVehicleData(veh, "Besitzer").."' AND ownerid = '"..getVehicleData(veh, "ID").."'")
				outputChatBox("Fahrzeug erfolgreich umgestellt!", player, 0, 255, 0)
			end
		end
	end
end)

local function hbrake(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if string.lower(getVehicleData(veh, "Besitzer")) == string.lower(getPlayerName(player)) then
			if getElementVelocity(veh) == 0 then
				if isElementFrozen(veh) == true then
					triggerClientEvent(player, "startBreakSound", player, 2)
					setElementFrozen(veh, false)
					outputChatBox("Die Handbremse wurde gelöst", player, 0, 255, 0)
				else
					triggerClientEvent(player, "startBreakSound", player, 1)
					setElementFrozen(veh, true)
					outputChatBox("Die Handbremse wurde angezogen", player, 0, 255, 0)
				end
			end
		end
	end
end

local function LightFunction(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
			if getVehicleData(veh, "Besitzer") == nil or string.lower(getVehicleData(veh, "Besitzer")) == string.lower(getPlayerName(player)) then
				if getVehicleOverrideLights(veh) == 1 then
					setVehicleOverrideLights(veh, 2)
				else
					setVehicleOverrideLights(veh, 1)
				end
			end
	end
end

TankTimer = {}

local function tankStateTimer(veh)
	setVehicleData(veh, "Fuel", getVehicleData(veh, "Fuel")-1)
	if getVehicleData(veh, "Fuel") <= 0 then
		setVehicleEngineState(veh, false)
		setVehicleData(veh, "Engine", 0)
		killTimer(TankTimer[veh])
	end
	if getVehicleData(veh, "Besitzer") then
		dbExec(handler, "UPDATE vehicles SET fuel = '"..getVehicleData(veh, "Fuel").."' WHERE vehowner = '"..getVehicleData(veh, "Besitzer").."' AND ownerid = '"..getVehicleData(veh, "ID").."'")
	end
end

local function motoring(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if getVehicleData(veh, "Besitzer") == nil or string.lower(getVehicleData(veh, "Besitzer")) == string.lower(getPlayerName(player)) then
			if getVehicleData(veh, "Fuel") == 0 then outputChatBox("Du solltest dich nach einem Kanister umschauen!", player, 255, 0, 0)return end
			if getVehicleEngineState(veh) == false then
				triggerClientEvent(player, "startEngineSound", player, 1)
				setTimer(
				function()
					setVehicleEngineState(veh, true)
					setVehicleData(veh, "Engine", 1)
					if getVehicleData(veh, "Fuel") == nil then
						setVehicleData(veh, "Fuel", 100)
					end
					if not (isTimer(TankTimer[veh])) then
						TankTimer[veh] = setTimer(tankStateTimer, 180000, 0,  veh)
					end
				end, 1000, 1)
			else
				triggerClientEvent(player, "startEngineSound", player, 2)
				setTimer(
				function()
					setVehicleEngineState(veh, false)
					setVehicleData(veh, "Engine", 0)
					if isTimer(TankTimer[veh]) then
						killTimer(TankTimer[veh])
					end
				end, 1000, 1)
			end
		end
	end
end



addEventHandler("onVehicleEnter", getRootElement(),
function(player, seat)
	if seat == 0 then
		local veh = getPedOccupiedVehicle(player)
		if not (getVehicleData(veh, "Engine") == 1) or getVehicleData(veh, "Engine") == nil  then
			setVehicleEngineState(veh, false)
		end
		if getVehicleOverrideLights(veh) == 0 then
			setVehicleOverrideLights(veh, 1)
		end
		if getVehicleData(veh, "Besitzer") == nil then
			bindKey(player, "M", "down", motoring)
			bindKey(player, "O", "down", LightFunction)
		elseif string.lower(getVehicleData(veh, "Besitzer")) == string.lower(getPlayerName(player)) then
			bindKey(player, "space", "down", hbrake)
			bindKey(player, "M", "down", motoring)
			bindKey(player, "O", "down", LightFunction)
		end
	end
end)


addEventHandler("onVehicleExit", getRootElement(),
function(player, seat)
	if isKeyBound(player, "space", "down", hbrake) then
		unbindKey(player, "space", "down", hbrake)
	end
	if isKeyBound(player, "M", "down", motoring) then
		unbindKey(player, "M", "down", motoring)
	end
	if isKeyBound(player, "O", "down", LightFunction) then
		unbindKey(player, "O", "down", LightFunction)
	end
end)

addEventHandler("onVehicleExplode", getRootElement(),
function()
	if getVehicleData(source, "SaveTy") == nil or getVehicleData(source, "SaveTy") == 0 then
		if not (getVehicleData(source, "Besitzer") == nil) then
			dbExec(handler, "DELETE FROM vehicles WHERE vehowner = '"..getVehicleData(source, "Besitzer").."' AND ownerid = '"..getVehicleData(source, "ID").."'")
			outputChatBox("Dein Fahrzeug wurde zerstört!", getPlayerFromName(getVehicleData(source, "Besitzer")), 255, 0, 0)
			destroyElement(source)
		else
			destroyElement(source)
		end
		if isTimer(TankTimer[source]) then
			killTimer(TankTimer[source])
		end
		setVehicleData(source, "Engine", 0)
	elseif getVehicleData(source, "SaveTy") == 1 then
		if isTimer(TankTimer[source]) then
			killTimer(TankTimer[source])
		end
		setTimer(
		function(source)
			dbExec(handler, "UPDATE vehicles SET insurance = '"..(1).."' WHERE vehowner = '"..getVehicleData(source, "Besitzer").."' AND ownerid = '"..getVehicleData(source, "ID").."'")
			destroyElement(source)
		end, 2000, 1, source)
		if getPlayerFromName(getVehicleData(source, "Besitzer")) then
			outputChatBox("Dein Fahrzeug wurde zerstört aber du hattest es versichert - Hole es in der Zentrale ab!", getPlayerFromName(getVehicleData(source, "Besitzer")), 255, 0, 0)
		end
	end
end)

-- TankFunktion
local fillCar
local price = 1.5


--[[addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	setTimer(
	function()
		price = 1.57
	end, 14400000, 0)
end)--]]

function fillCar(veh, fuelState)
	if veh == nil and fuelState == nil then print("TankFunktionError (fillCar)") return end
		local old = getVehicleData(veh, "Fuel")
		setVehicleData(veh, "Fuel", fuelState)
		local new = getVehicleData(veh, "Fuel")
		local result = math.floor((((new - old) *price)* 100)/100)
		dbExec(handler, "UPDATE vehicles SET fuel = '"..fuelState.."' WHERE vehowner ='"..getVehicleData(veh, "Besitzer").."' AND ownerid = '"..getVehicleData(veh, "ID").."'")
		outputChatBox("Du hast "..result.." $ bezahlt.", getPlayerFromName(getVehicleData(veh, "Besitzer")), 0, 255, 0)
		
end

local counter = {}

addEventHandler("onElementClicked", getRootElement(),
function(button, state, player)
	if button == "left" and state == "down" then
		if getElementModel(source) == 3465 or getElementModel(source) == 1686 or getElementModel(source) == 1244 or getElementModel(source) == 1676 then
			if counter[player] == nil then 
				local px, py, pz = getElementPosition(player)
				local mx, my, mz = getElementPosition(source)
				counter[player] = {[1] = 0}
				if getDistanceBetweenPoints3D(px, py, pz, mx, my, mz) <= 9 then
					if not (isPedInVehicle(player)) then
						local shape = "Col"..getPlayerName(player)
						shape = createColSphere(mx, my, mz, 11)
						counter[player] = {[1] = 0, [2] = mx, [3] = my, [4] = mz, [5] = 1}
						for k, v in ipairs(getElementsByType("vehicle")) do
							if isElementWithinColShape(v, shape) and getVehicleData(v, "Besitzer") == string.lower(getPlayerName(player)) then
								counter[player][1] = counter[player][1] +1
								if counter[player][1] > 1 then
									outputChatBox("Es stehen mehrere Fahrzeuge im Umkreis der Tankstelle!", player, 255, 0, 0)
								end
								if counter[player][1] == 1 then
									triggerClientEvent(player, "startpetrolStGuiWeb", player)
								end
								if counter[player][1] > 0 then
									triggerClientEvent(player, "fillCombo", player, getVehicleName(v), price, getVehicleData(v, "ID"))
								end
							end
						end
						destroyElement(shape)
						
					else
						outputChatBox("Du kannst das Fahrzeug nur von außen betanken!", player, 255, 0, 0)
						counter[player] = nil
					end
				end
			end
		end	
	end
	if not (counter[player] == nil) and counter[player][1] == 0 then
		counter[player] = nil
	end
end)

-- Tank Gui Funktion

addEvent("fillVehicleServerSide", true)
addEventHandler("fillVehicleServerSide", getRootElement(),
function(text)
	if client == source then
		local id = gettok(text, 2, string.byte("|"))
			if VehByName[string.lower("veh"..getPlayerName(source)..id)] then
				local car = VehByName[string.lower("veh"..getPlayerName(source)..id)]
				local cX, cY, cZ = getElementPosition(car)
				if getDistanceBetweenPoints3D(counter[source][2], counter[source][3], counter[source][4], cX, cY, cZ) <= 9 then
					if not (getVehicleData(car, "Fuel") == 100) then
						local old = getVehicleData(car, "Fuel")
						fillCar(car, 100)
						local new = getVehicleData(car, "Fuel")
						outputChatBox("Alter Stand: "..old.."\nNeuer Füllstand: "..new)
					else
						outputChatBox("Dein Fahrzeug ist bereits vollgetankt!", source, 255, 0, 0)
					end
				else
					outputChatBox("Das Fahrzeug steht nicht mehr in der Nähe!", source, 255, 0, 0)
				end
			end
			
	end
end)

addEvent("onPetrolGUIClose", true)
addEventHandler("onPetrolGUIClose", getRootElement(),
function()
	if source == client then
		counter[source] = nil
		outputChatBox("Die Tankstelle wünscht Ihnen eine gute Weiterfahrt!", source, 0, 255, 0)
	end
end)
--- Autohaus...


addEvent("buyCarServerSide", true)
addEventHandler("buyCarServerSide", getRootElement(),
function(element, variant)
	if source == client then
		local vRandom = math.random(0, 255)
		if variant == 1 then
			local x = 2119
			local y = -1152.0999755859
			local z = 25
			veh = createNewVehicle(element, x, y, z, 0, 0, 0, "", vRandom, vRandom, vRandom, getPlayerName(source),  100, false,  true, true)--- Fahrzeug für die Datenbank
		else
-- 		...

		end
	end
end)