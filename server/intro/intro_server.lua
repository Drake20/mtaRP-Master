local dim = 0
local cMarker;
local a;
local b;
local trailerA;
local trailerB;
local lockf;
local Marker1;
local Marker2;
local IntroPlayer = {
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "",
	[6] = "",
	[7] = "",
	[8] = "",
	[9] = ""
}

addEvent("spawnPlayerOverIntro", true)
addEventHandler("spawnPlayerOverIntro", getRootElement(),
function()
	dim = dim+1
	spawnPlayer(source, 2856.8000488281, 1290.9000244141, 11.39999961853, 270.001403, 250)
	setCameraTarget(source, source)  
				IntroPlayer[source] = {
					[1] = 1, 
					[2] = createObject(963, 2855.8000488281, 1279.0999755859, 11.39999961853, 90, 0, 90),
					[3] = createVehicle(538, 2864.6999511719, 1258, 12.199999809265, 0, 0, 0),
					[4] = createVehicle(570, 2864.8999023438, 1305.0999755859, 12.39999961853, 0, 0, 0),
					[5] = createVehicle(570, 2864.8999023438, 1284.5, 12.39999961853, 0, 0, 0),
					[6] = createPed(255, 0, 0, 0),
					[7] = createMarker(1946.1999511719, -1954, 11.800000190735, "cylinder", 5, 0, 0, 0, 0),
					[8] = createMarker(1705.6999511719, -1953.5, 11.8, "cylinder", 5, 0, 0, 0, 0),
					[9] = "nein",
					[10] = 0,
					[11] = createPed(172, 1734.9000244141, -1943.8000488281, 13.60000038147)
				}		
			

addEventHandler("onMarkerHit", IntroPlayer[source][8],
function(element, dimension)
	 if dimension == true then
		if getElementModel(element) == 538 then
			outputChatBox("t212", getRootElement())
			setTrainSpeed(element, 0)
			outputChatBox("endlich", getRootElement())
			if getVehicleTowedByVehicle(element) then
			local tr1 = getVehicleTowedByVehicle(element)
				if getVehicleOccupant(tr1, 1) then
					local play = getVehicleOccupant(tr1, 1)
					toggleAllControls(play, true)
					setControlState(play, "enter_exit", true)
					triggerClientEvent(play, "startLastrender", play)
					showPlayerHudComponent(play, "radar", true)
					IntroPlayer[play][9] = "ja"
					outputChatBox("ja", getRootElement())
				elseif getVehicleOccupant(getVehicleTowedByVehicle(tr1), 1) then
					local play = getVehicleOccupant(getVehicleTowedByVehicle(tr1), 1)
					triggerClientEvent(play, "startLastrender", play)
					toggleAllControls(play, true)
					setControlState(play, "enter_exit", true)
					showPlayerHudComponent(play, "radar", true)
					IntroPlayer[play][9] = "ja"
				end
			end
		end
	end
end)
				
				-- Dimension --
				
				setElementDimension(IntroPlayer[source][2], dim)
				setElementDimension(IntroPlayer[source][3], dim)
				setElementDimension(IntroPlayer[source][4], dim)
				setElementDimension(IntroPlayer[source][5], dim)
				setElementDimension(source, dim)
				setElementDimension(IntroPlayer[source][6], dim)
				setElementDimension(IntroPlayer[source][7], dim)
				setElementDimension(IntroPlayer[source][8], dim)
				setElementDimension(IntroPlayer[source][11], dim)
				
				--  Zugeigenschaften
				
				warpPedIntoVehicle(IntroPlayer[source][6], IntroPlayer[source][3])
				setTrainDirection(IntroPlayer[source][3], true)
				setTrainDerailable(IntroPlayer[source][3], true)
				attachTrailerToVehicle(IntroPlayer[source][3], IntroPlayer[source][4])
				attachTrailerToVehicle(IntroPlayer[source][4], IntroPlayer[source][5])
				
				-- Sonstiges --
				
				setPlayerMoney(source, 50)
				triggerClientEvent(source, "createIntroMarker", source, dim)
				
				-- Ped --
				
				setElementFrozen(IntroPlayer[source][11], true)
				setPedAnimation(IntroPlayer[source][11], "ped", "IDLE_chat")
				setElementRotation(IntroPlayer[source][11], 0, 0, 180)
end)


-- Eventhandler


local function startEnterTrain(player, seat)
	if getElementModel(source) == 570 then
		if IntroPlayer[player][1] == 1 then
			if IntroPlayer[player][9] == "ja" then
				cancelEvent()
				return
			end
			if getElementModel(source) == 538 then
				cancelEvent()
			elseif getElementModel(source) == 570 then
				outputChatBox(seat, player)
				if not (IntroPlayer[player][10] == 1) then
					outputChatBox("Du musst erst ein Ticket ziehen!", player, 255, 0, 0)
					cancelEvent()
				end
			end
		end
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), startEnterTrain)

 --Clientseitig setzen  ToDo 

local function EnterTutTrain(vehicle)
	if IntroPlayer[source] == nil then return end
		if IntroPlayer[source][1] == 1 then
			triggerClientEvent(source, "startSpeedTimers", source, IntroPlayer[source][3])
			triggerClientEvent(source, "startClientTipps", source)
			toggleAllControls(source, false)
			showPlayerHudComponent(source, "radar", false)
		end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), EnterTutTrain)--]]


addEventHandler("onElementClicked", getRootElement(),
function(button, state, player)
	if button == "left" and state == "down" then
		if IntroPlayer[player] == nil then return end
		if IntroPlayer[player][1] == 1  and IntroPlayer[player][10] == 0 then
			if getElementModel(source) == 963 then
				outputChatBox("Wähle den Los Santos Hauptbahnhof aus!", player, 0, 255, 0)
				triggerClientEvent(player, "startTicketScreen", player)
				triggerClientEvent(player, "startTrainIntro", player)
			end
		end
	end
end)

addEventHandler("onElementClicked", getRootElement(),
function(button, state, player)
	if button == "left" and state == "down" then
		if IntroPlayer[player] == nil then return end
		if IntroPlayer[player][1] == 1 and IntroPlayer[player][9] == "ja" then
			if getElementModel(source) == 172 then
				IntroPlayer[player][1] = 0
				triggerClientEvent(player, "startTutorialScreen", player)
			end
		end
	end
end)

addEvent("deleteObjects", true)
addEventHandler("deleteObjects", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = '"..getPlayerName(source).."'")
		local result = dbPoll(query, -1)
		if result and #result == 1 then
			local eins = 1
			dbExec(handler, "UPDATE users SET intro = '"..eins.."' WHERE spieler = '"..getPlayerName(source).."'")
			for k, v in ipairs (IntroPlayer[source]) do
				if not (k == 1 or k == 9 or k == 10) then
					destroyElement(v)
				end
			end
				outputChatBox("Du hast das Tutorial  erfolgreich abgeschlossen!", source, 0, 255, 0)
				IntroPlayer[source] = nil
	
				setElementDimension(source, 0)
		else
			dbFree(query)
		end
	end
end)

addEvent("setTableIntro", true)
addEventHandler("setTableIntro", getRootElement(),
function()
	if source == client then
		setPlayerMoney(source, 0)
		IntroPlayer[source][10] = 1
	end
end)

				
----