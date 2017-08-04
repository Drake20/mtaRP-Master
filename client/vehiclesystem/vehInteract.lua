addEvent("loadVehicleBriefURL", true)
addEventHandler("loadVehicleBriefURL", getRootElement(),
function()
	loadBrowserURL(windowTable[string.lower("thevehInteractBrowser")], "http://mta/general/client/vehiclesystem/playerIndex.html")
	triggerServerEvent("selectPlayersInRadius", getLocalPlayer())
end)


addEvent("insertPlayersIntoWeb", true)
addEventHandler("insertPlayersIntoWeb", getLocalPlayer(),
function(var)
	local variable = "'"..var.."'"
	executeBrowserJavascript(windowTable[string.lower("thevehInteractBrowser")], "addIntoComboBox("..variable..")")
end)