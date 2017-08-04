local screenW, screenH = guiGetScreenSize()
local variable = 0
local Office;
local theOffice;
local createOfficeBr;


addEvent("startOfficeWeb", true)
addEventHandler("startOfficeWeb", getLocalPlayer(),
function()
	if variable == 0 then
		variable = 1
		Office = guiCreateBrowser((screenW-300)/2, (screenH-450)/2, 300, 450, true, false, false)
		theOffice = guiGetBrowser(Office)
		function createOfficeBr()
			loadBrowserURL(source, "http://mta/general/client/vehiclesystem/choose.html")
		end
		addEventHandler("onClientBrowserCreated", theOffice, createOfficeBr)
		showCursor(true)
	end
end)


addEvent("chooseVariant1", true)
addEventHandler("chooseVariant1", getRootElement(),
function()
	triggerServerEvent("forVehIds", getLocalPlayer())
	loadBrowserURL(theOffice, "http://mta/general/client/vehiclesystem/office.html")
end)

addEvent("chooseVariant2", true)
addEventHandler("chooseVariant2", getRootElement(),
function()
	triggerServerEvent("forVehIds", getLocalPlayer())
	loadBrowserURL(theOffice, "http://mta/general/client/vehiclesystem/officeExit.html")
end)

addEvent("chooseVariant3", true)
addEventHandler("chooseVariant3", getRootElement(),
function()
	triggerServerEvent("forVehIds", getLocalPlayer())
	loadBrowserURL(theOffice, "http://mta/general/client/vehiclesystem/officeSavety.html")
end)
addEvent("chooseVariant4", true)
addEventHandler("chooseVariant4", getRootElement(),
function()
	
end)

addEvent("VehicleOfficeAn", true)
addEventHandler("VehicleOfficeAn", getRootElement(),
function(kennzeichen, id)
	triggerServerEvent("enterDBVehicleOffice", getLocalPlayer(), getPlayerName(getLocalPlayer()), kennzeichen, id)
end)

addEvent("VehicleOfficeExit", true)
addEventHandler("VehicleOfficeExit", getRootElement(),
function(id)
	triggerServerEvent("exitDBVehicleOffice", getLocalPlayer(), id)
end)

addEvent("VehicleOfficeSaveTy", true)
addEventHandler("VehicleOfficeSaveTy", getRootElement(),
function(id)
	triggerServerEvent("savetyDBVehicleOffice", getLocalPlayer(), id)
end)

addEvent("closeOfficeWindow", true)
addEventHandler("closeOfficeWindow", getLocalPlayer(),
function()
	removeEventHandler("onClientBrowserCreated", theOffice, createOfficeBr)
	guiSetVisible(Office, false)
	variable = 0
	showCursor(false)
end)

addEvent("closeOfficeWebWindow", true)
addEventHandler("closeOfficeWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", theOffice, createOfficeBr)
	guiSetVisible(Office, false)
	variable = 0
	showCursor(false)
end)
