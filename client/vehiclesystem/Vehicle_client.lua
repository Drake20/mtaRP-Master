addEvent("startEngineSound", true)
addEventHandler("startEngineSound", getLocalPlayer(),
function(value)
	if value == 1 then
		playSound("http://gamerzcom.de/on.mp3")
	elseif value == 2 then
		playSound("http://gamerzcom.de/off.mp3")
	end
end)


addEvent("startLockedSound", true)
addEventHandler("startLockedSound", getLocalPlayer(),
function()
	playSound("http://gamerzcom.de/lock.mp3")
end)



addEvent("startBreakSound", true)
addEventHandler("startBreakSound", getLocalPlayer(),
function(value)
	if value == 1 then
		playSound("http://gamerzcom.de/break.mp3")
	elseif value == 2 then
		playSound("http://gamerzcom.de/breakdown.mp3")
	end
end)

-- Radio Funktion

local Radio = false;
local stopRadio;
local radioSound;
local changeRadioChannel;

local RadioChannel = {
	[1] = "http://metafiles.gl-systemhaus.de/hr/youfm_2.m3u",
	["beschreibung"..(1)] = "You FM",
	[2] = "http://www.iloveradio.de/iloveradio.m3u",
	["beschreibung"..(2)] = "I love Radio",
}
local maxRadioChannel =  2;

local RadioState = {}
local saveChannel = {}

function changeRadioChannel(key, state,nummer)
	if key == "pgup" then
		if saveChannel[getLocalPlayer()] == maxRadioChannel then
			saveChannel[getLocalPlayer()] = 1
			if Radio == true then
				stopSound(radioSound)
			end
			outputChatBox("Du hörst jetzt "..RadioChannel["beschreibung"..saveChannel[getLocalPlayer()]], 0, 255, 0)
			radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
		else
			saveChannel[getLocalPlayer()] = saveChannel[getLocalPlayer()]+1
			if Radio == true then
				stopSound(radioSound)
			end
			outputChatBox("Du hörst jetzt "..RadioChannel["beschreibung"..saveChannel[getLocalPlayer()]], 0, 255, 0)
			radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
		end
	elseif key == "pgdn" then
		if saveChannel[getLocalPlayer()] == 1 then
			saveChannel[getLocalPlayer()] = maxRadioChannel
			if Radio == true then
				stopSound(radioSound)
			end
			outputChatBox("Du hörst jetzt "..RadioChannel["beschreibung"..saveChannel[getLocalPlayer()]], 0, 255, 0)
			radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
		else
			saveChannel[getLocalPlayer()] = saveChannel[getLocalPlayer()]-1
			if Radio == true then
				stopSound(radioSound)
			end
			outputChatBox("Du hörst jetzt "..RadioChannel["beschreibung"..saveChannel[getLocalPlayer()]], 0, 255, 0)
			radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
		end
	elseif key == nil then
			saveChannel[getLocalPlayer()] = nummer
			if Radio == true then
				stopSound(radioSound)
			end
			outputChatBox("Du hörst jetzt "..RadioChannel["beschreibung"..saveChannel[getLocalPlayer()]], 0, 255, 0)
			radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
			
	end
end

local function RadioOn()
	if Radio == false then
			local veh = getPedOccupiedVehicle(getLocalPlayer())
			if not (saveChannel[getLocalPlayer()] == nil) then
				changeRadioChannel(nil, nil, saveChannel[getLocalPlayer()])
			else
				saveChannel[getLocalPlayer()] = 1
				radioSound = playSound(RadioChannel[saveChannel[getLocalPlayer()]])
				outputChatBox("Radio eingeschaltet.")
			end
			if RadioState[getPedOccupiedVehicle(getLocalPlayer())] == nil then
				bindKey("pgup", "down", changeRadioChannel)
				bindKey("pgdn", "down", changeRadioChannel)
			end
			RadioState[veh] = 1
			Radio = true
			unbindKey("k", "down", RadioOn)
			bindKey("k", "down", stopRadio)
	end
end

function stopRadio()
	if Radio == true then
			local veh = getPedOccupiedVehicle(getLocalPlayer())
			RadioState[veh] = nil
			stopSound(radioSound)
			unbindKey("k", "down", stopRadio)
			bindKey("k", "down", RadioOn)
			unbindKey("pgup", "down", changeRadioChannel)
			unbindKey("pgdn", "down", changeRadioChannel)
			outputChatBox("Radio ausgeschaltet!")
			Radio = false
	end
end

addEventHandler("onClientVehicleEnter", getRootElement(),
function(player)
	if player == getLocalPlayer() then
		if RadioState[source] == 1 then
			RadioOn()
			bindKey("pgup", "down", changeRadioChannel)
			bindKey("pgdn", "down", changeRadioChannel)
		else
			bindKey("k", "down", RadioOn)
		end
	end
end)

addEventHandler("onClientVehicleExit", getRootElement(),
function(player)
	if player == getLocalPlayer() then
		unbindKey("k", "down", RadioOn)
		if radioSound == nil or radioSound == false or Radio == false then return end
		if isSoundPanningEnabled(radioSound) then
			stopSound(radioSound)
			unbindKey("k", "down", stopRadio)
			unbindKey("pgup", "down", changeRadioChannel)
			unbindKey("pgdn", "down", changeRadioChannel)
			Radio = false
		end
	end
end)

addEventHandler("onClientVehicleExplode", getRootElement(), 
function()
	if Radio == true then
		stopSound(radioSound)
		outputChatBox("Death")
		RadioState[source] = nil
	end
end)

addEvent("noCollision", true)
addEventHandler("noCollision", getLocalPlayer(),
function(element, time)
		setElementAlpha(element, 200)
			for index,vehicle in ipairs(getElementsByType("vehicle")) do 
				setElementCollidableWith(vehicle, element, false)
			end
		setTimer(
		function(element)
			
			for index,vehicle in ipairs(getElementsByType("vehicle")) do 
				setElementCollidableWith(vehicle, element, true)
			end
			setElementAlpha(element, 255)
		end, time, 1, element)
end)


local screenW, screenH = guiGetScreenSize()
local variable = 0
local petrolStGui;
local thePetrolStGui;
local createPetrolStGuiBr;
local returnTimer;

addEvent("startpetrolStGuiWeb", true)
addEventHandler("startpetrolStGuiWeb", getLocalPlayer(),
function()
	if variable == 0 then
		variable = 1
		petrolStGui = guiCreateBrowser((screenW-300)/2, (screenH-450)/2, 300, 450, true, false, false)
		thePetrolStGui = guiGetBrowser(petrolStGui)
		function createPetrolStGuiBr()
			loadBrowserURL(source, "http://mta/general/client/vehiclesystem/Petrol_Stations.html")
		end
		addEventHandler("onClientBrowserCreated", thePetrolStGui, createPetrolStGuiBr)
		showCursor(true)
	end
end)

addEvent("fillCombo", true)
addEventHandler("fillCombo", getRootElement(),
function(model, price, id)
		if not guiGetVisible(petrolStGui) then
			while (not guiGetVisible(petrolStGui)) do
				setTimer(returnTimer, 500,1, model, price, id)
			end
		else
			setTimer(returnTimer, 500,1, model, price, id)
		end
end)



function returnTimer(model, price, id)
	local veh = "'"..model.."'"
	executeBrowserJavascript(thePetrolStGui, "fuellCarList("..veh..","..id..")")
	executeBrowserJavascript(thePetrolStGui, "getPetrolPrice("..(price)..")")
end

--Java

addEvent("closePetrolWebWindow", true)
addEventHandler("closePetrolWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", thePetrolStGui, createPetrolStGuiBr)
	guiSetVisible(petrolStGui, false)
	variable = 0
	showCursor(false)
	guiSetInputEnabled(false)
	triggerServerEvent("onPetrolGUIClose", getLocalPlayer())
end)

addEvent("fillVehicle", true)
addEventHandler("fillVehicle", getRootElement(),
function(output)
	triggerServerEvent("fillVehicleServerSide", getLocalPlayer(), output)
end)







