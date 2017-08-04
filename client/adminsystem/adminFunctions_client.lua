local s = false
local sp = ""
local spy = false
local spect = false

local function SpecEnter(player, seat)
	if sp == player then
		setCameraTarget(source)
	end
end

local function SpecExit(player, seat)
	if sp == player then
		setCameraTarget(sp)
	end
end

local function SupportMode()
	cancelEvent()
end

local function SpyModeProt()
	cancelEvent()
end

addEvent("SupportAlpha", true)
addEventHandler("SupportAlpha", getLocalPlayer(),
function()
	if s == false then
		addEventHandler("onClientPlayerDamage", getLocalPlayer(), SupportMode)
		s = true
	elseif s == true then
		removeEventHandler("onClientPlayerDamage", getLocalPlayer(), SupportMode)
		s =  false
	end
end)

addEvent("SpecVehicleEnter", true)
addEventHandler("SpecVehicleEnter", getLocalPlayer(),
function(spieler)
	if spy == false then
		sp = spieler 
		addEventHandler("onClientVehicleEnter", getRootElement(), SpecEnter)
		addEventHandler("onClientVehicleExit", getRootElement(), SpecExit)
		spy = true
	elseif spy == true then
		removeEventHandler("onClientVehicleEnter", getRootElement(), SpecEnter)
		removeEventHandler("onClientVehicleExit", getRootElement(), SpecExit)
		spy = false
	end
end)


addEvent("SpectMode", true)
addEventHandler("SpectMode", getLocalPlayer(),
function()
	if spect == false then
		addEventHandler("onClientPlayerDamage", getLocalPlayer(), SpyModeProt)
		spect = true
	elseif spect == true then
		removeEventHandler("onClientPlayerDamage", getLocalPlayer(), SpyModeProt)
		spect =  false
	end
end)