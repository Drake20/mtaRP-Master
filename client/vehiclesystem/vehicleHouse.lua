local screenW, screenH = guiGetScreenSize()
local variable = 0
local vehHouseBrowser;
local theVehHouseBrowser;
local createVehHouseBrowser;
local returnTimer;
local spawnCar;

addEvent("startvehHouseBrowserWeb", true)
addEventHandler("startvehHouseBrowserWeb", getLocalPlayer(),
function()
	if variable == 0 then
		variable = 1
		vehHouseBrowser = guiCreateBrowser((screenW-300), (screenH-450)/2, 300, 450, true, false, false)
		theVehHouseBrowser = guiGetBrowser(vehHouseBrowser)
		function createVehHouseBrowser()
			loadBrowserURL(source, "http://mta/general/client/vehiclesystem/vehHouse.html")
		end
		addEventHandler("onClientBrowserCreated", theVehHouseBrowser, createVehHouseBrowser)
		showCursor(true)
	end
end)

addEvent("fillVehHouseBox", true)
addEventHandler("fillVehHouseBox", getRootElement(),
function(model)
		if not guiGetVisible(vehHouseBrowser) then
			while (not guiGetVisible(vehHouseBrowser)) do
				setTimer(returnTimer, 500,1, model)
			end
		else
			setTimer(returnTimer, 500,1, model)
		end
end)

local var = 0
local startRendering

function startRendering ()
	if var == 360 then
		var = 1
	end
	var = var+1
	setElementRotation(spawnCar, 0, 0, var)
end

addEvent("spawnVehForSchutz", true)
addEventHandler("spawnVehForSchutz", getLocalPlayer(),
function()
	spawnCar = createVehicle(495, 2132.6999511719, -1175.6999511719, 24.700000762939, 0, 0, 0, "Schutz")
	setCameraMatrix(2127.447265625, -1165.875, 26.83046913147, 2168.0986328125, -1252.83984375, -1.1808001995087)
	addEventHandler("onClientRender", getRootElement(), startRendering)
end)

function returnTimer(model)
	local veh = "'"..model.."'"
	executeBrowserJavascript(theVehHouseBrowser, "fuellVehHouseList("..veh..")")
end

--Java

addEvent("changeElementInHouse", true)
addEventHandler("changeElementInHouse", getRootElement(),
function(name)
	setElementModel(spawnCar, getVehicleIDFromName(name))
end)

addEvent("buyCarServerSide_1", true)
addEventHandler("buyCarServerSide_1", getRootElement(),
function(element)
	triggerServerEvent("buyCarServerSide", getLocalPlayer(), getVehicleIDFromName(element), 1)
end)


addEvent("closeSchutzHouseWebWindow", true)
addEventHandler("closeSchutzHouseWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", theVehHouseBrowser, createVehHouseBrowser)
	guiSetVisible(vehHouseBrowser, false)
	variable = 0
	showCursor(false)
	guiSetInputEnabled(false)
	removeEventHandler("onClientRender", getRootElement(), startRendering)
	destroyElement(spawnCar)
	setCameraTarget(getLocalPlayer())
	var = 1
end)