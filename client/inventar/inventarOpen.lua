local screenW, screenH = guiGetScreenSize()
local variable = 0
local inventarBrowser;
local theInventarBrowser;
local createInventarBrowser;
local callBack = false;
local timerReturn
local timerR
local objectEditor;

bindKey("U", "down",
function()
	if variable == 0 then
		variable = 1
		inventarBrowser = guiCreateBrowser((screenW-400)/2, (screenH-450)/2, 400, 450, true, false, false)
		theInventarBrowser = guiGetBrowser(inventarBrowser)
		function createInventarBrowser()
			loadBrowserURL(source, "http://mta/general/client/inventar/inventar.html")
			timerR = setTimer(timerReturn, 70, 0)
		end
		addEventHandler("onClientBrowserCreated", theInventarBrowser, createInventarBrowser)
		showCursor(true)
	end
end)

function timerReturn()
	if callBack == false then
		executeBrowserJavascript(theInventarBrowser, "callBackFunc()")
	elseif callBack == true then
		killTimer(timerR)
		triggerServerEvent("fuellServersideInventar", getLocalPlayer())
	end
end

addEvent("fillGridListFromInventar", true)
addEventHandler("fillGridListFromInventar", getRootElement(),
function(var11, var22, var3)
	local String1 = "'"..var11.."'"
	local String2 = "'"..var22.."'"
	local String3 = "'"..var3.."'"
	executeBrowserJavascript(theInventarBrowser, "fuellTheGridList("..String1..","..String2..","..String3..")")
end)

addEvent("triggerToScriptLicences", true)
addEventHandler("triggerToScriptLicences", getRootElement(),
function(var1, var2, var3)
	local String1 = "'"..var1.."'"
	local String2 = "'"..var2.."'"
	local String3 = "'"..var3.."'"	
	executeBrowserJavascript(theInventarBrowser, "fuellkategorieWithObjekts("..String1..","..String2..","..String3..")")
end)


addEvent("writeKategorieLicences", true)
addEventHandler("writeKategorieLicences", getRootElement(),
function(kate1, kate2, kate3, state)
	local String1 = "'"..kate1.."'"
	local String2 = "'"..kate2.."'"
	local String3 = "'"..kate3.."'"		
	executeBrowserJavascript(theInventarBrowser, "writeKare("..String1..","..String2..","..String3..")")
	if state == true then
		objectEditor = true
	elseif state == nil or state == false then
		objectEditor = false
	end
end)


--Java


addEvent("callBackResult", true)
addEventHandler("callBackResult", getRootElement(),
function()
	callBack = true
end)

addEvent("closeInventarWebWindow", true)
addEventHandler("closeInventarWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", theInventarBrowser, createInventarBrowser)
	guiSetVisible(inventarBrowser, false)
	variable = 0
	showCursor(false)
	guiSetInputEnabled(false)
	if isTimer(timerR) then
		killTimer(timerR)
	end
	var = 1
	callBack = false;
end)

addEvent("showServerLicences", true)
addEventHandler("showServerLicences", getRootElement(),
function()
	triggerServerEvent("ServerQueryLicences", getLocalPlayer())
end)

addEvent("showServerObjects", true)
addEventHandler("showServerObjects", getRootElement(),
function()
	triggerServerEvent("ServerQueryObjects", getLocalPlayer())
end)

addEvent("showTheVehicleKeys", true)
addEventHandler("showTheVehicleKeys", getRootElement(),
function()
	triggerServerEvent("serverSendKeysToInventar", getLocalPlayer())
end)
--- Tests

addEvent("sendMessageTO", true)
addEventHandler("sendMessageTO", getRootElement(),
function(id)
outputChatBox(id)
	if objectEditor == true then
		startObjectEditor(tonumber(id))
			removeEventHandler("onClientBrowserCreated", theInventarBrowser, createInventarBrowser)
		guiSetVisible(inventarBrowser, false)
		variable = 0
		guiSetInputEnabled(false)
		if isTimer(timerR) then
			killTimer(timerR)
		end
		var = 1
		callBack = false;
	end
end)