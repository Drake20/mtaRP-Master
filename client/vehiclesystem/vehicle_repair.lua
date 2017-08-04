local screenW, screenH = guiGetScreenSize()
local Repair;
local theReapair;
local variable = 0
local location;
local matrix = 1

addEvent("startRepairWeb", true)
addEventHandler("startRepairWeb", getLocalPlayer(),
function(repairLocation, var)
	if variable == 0 then
		variable = 1
		location = repairLocation
		Repair = guiCreateBrowser(0, screenH-450, 300, 450, true, false, false) --(screenH-450)/2
		theReapair = guiGetBrowser(Repair)
		function createRepairBr()
			loadBrowserURL(source, "http://mta/general/client/vehiclesystem/RepairChoose.html")
		end
		addEventHandler("onClientBrowserCreated", theReapair, createRepairBr)
		if var == 0 then
			outputChatBox("CRichtig")
			executeBrowserJavascript(theReapair, "disableRepair()")
		end
		showCursor(true)
	end
end)

addEvent("VehicleRepairWebRep", true)
addEventHandler("VehicleRepairWebRep", getRootElement(),
function()
	triggerServerEvent("repairVehicleFromWeb", getLocalPlayer())
end)

addEvent("VehicleRepairComming", true)
addEventHandler("VehicleRepairComming", getRootElement(),
function()
	outputChatBox("Comming soon", 0, 255, 0)
end)

addEvent("VehicleChangeLackWinBrow", true)
addEventHandler("VehicleChangeLackWinBrow", getRootElement(),
function()
	loadBrowserURL(theReapair, "http://mta/general/client/vehiclesystem/repairFarb.html")
end)

addEvent("loadChoosePage", true)
addEventHandler("loadChoosePage", getRootElement(),
function()
	loadBrowserURL(theReapair, "http://mta/general/client/vehiclesystem/RepairChoose.html")
end)


addEvent("ClientLack1Veh", true)
addEventHandler("ClientLack1Veh", getRootElement(),
function(r, g, b, r2, g2, b2)
	triggerServerEvent("ServerLack1Vehicle", getLocalPlayer(), r, g, b, r2, g2, b2)
end)

addEvent("clientPaintBuy", true)
addEventHandler("clientPaintBuy", getRootElement(),
function(r, g, b, r2, g2, b2)
	triggerServerEvent("buyVehiclePaint", getLocalPlayer(), r, g, b, r2, g2, b2)
end)

addEvent("VehicleSetCamera", true)
addEventHandler("VehicleSetCamera", getRootElement(),
function()
	if matrix == 1 then
		setCameraMatrix(620.9892578125, -131.2392578125, 1000.4154052734, 547.00390625, -66.69921875, 981.42370605469)
		matrix = 2
	elseif matrix == 2 then
		setCameraMatrix(608.8525390625, -124.0361328125, 997.50537109375, 708.796875, -126.1865234375, 1000.0527954102)
		matrix = 3
	elseif matrix == 3 then
		setCameraMatrix(621.529296875, -124.3330078125, 1000.5016479492, 527.392578125, -125.4521484375, 966.78179931641)
		matrix = 4
	elseif matrix == 4 then
		setCameraMatrix(609.2421875, -118.9423828125, 1000.5704956055, 680.802734375, -181.9765625, 970.47210693359)
		matrix = 1
	end	
end)



addEvent("closeRepairWebWindow", true)
addEventHandler("closeRepairWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", theReapair, createRepairBr)
	guiSetVisible(Repair, false)
	variable = 0
	showCursor(false)
	triggerServerEvent("removePedFromRepairRoom", getLocalPlayer(), location)
end)