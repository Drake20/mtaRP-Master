local screenW, screenH = guiGetScreenSize();
local variable = 0;
local callBack = false;
local timerReturn;
local timerR;
local supportWindow;
local theSupportWindow;
local supportEvent;
local url;
local timerReadFor;
local timerSupp;

addCommandHandler("report",
function()
	if variable == 0 then
		variable = 1
		supportWindow = guiCreateBrowser((screenW-200)/2, (screenH-250)/2, 240, 250, true, false, false)
		theSupportWindow = guiGetBrowser(supportWindow)
		triggerServerEvent("allowNotCursor", getLocalPlayer())
		url = "http://mta/general/client/supportsystem/supportEnterpage.html"
		guiSetInputMode("no_binds")
		function supportEvent()
			loadBrowserURL(theSupportWindow, url)
			timerR = setTimer(timerReturn, 70, 0)
		end
		addEvent("closeSupportGUI", true)
		addEventHandler("closeSupportGUI", getRootElement(),
		function()
			triggerServerEvent("allowCursor", getLocalPlayer())
			removeEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)
			guiSetVisible(supportWindow, false)
			variable = 0
			showCursor(false)
			guiSetInputMode("allow_binds")
			guiSetInputEnabled(false)
			
			if isTimer(timerR) then
				killTimer(timerR)
			end
			callBack = false;
		end)	
		addEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)
		showCursor(true)
	end
end)

addEvent("callBackSupportResult", true)
addEventHandler("callBackSupportResult", getRootElement(),
function()
	callBack = true
end)

function timerReturn()
	if callBack == false then
		executeBrowserJavascript(theSupportWindow, "callBackFuncSupp()")
	elseif callBack == true then
		killTimer(timerR)
		callBack = false
	end
end

function timerReadFor()
	if callBack == false then
		executeBrowserJavascript(theSupportWindow, "callBackFuncSupp()")
	elseif callBack == true then
		killTimer(timerSupp)
		triggerServerEvent("startSupportReadTable", getLocalPlayer())
		callBack = false
	end
end

addEvent("loadBrowserSupportRead", true)
addEventHandler("loadBrowserSupportRead", getRootElement(),
function()
	url = "http://mta/general/client/supportsystem/supportRead.html"
	removeEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)	
	destroyElement(supportWindow)
	supportWindow = guiCreateBrowser((screenW-800)/2, (screenH-600)/2, 800, 600, true, false, false)
	theSupportWindow = nil
	theSupportWindow = guiGetBrowser(supportWindow)
	addEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)
	timerSupp = setTimer(timerReadFor, 70, 0)
end)


addEvent("loadBrowserSupportWrite", true)
addEventHandler("loadBrowserSupportWrite", getRootElement(),
function()
	url = "http://mta/general/client/supportsystem/supportWrite.html"
	removeEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)	
	destroyElement(supportWindow)
	supportWindow = guiCreateBrowser((screenW-480)/2, (screenH-430)/2, 480, 430, true, false, false)
	theSupportWindow = nil
	theSupportWindow = guiGetBrowser(supportWindow)	
	addEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)
end)



addEvent("writeServerSupportTicket", true)
addEventHandler("writeServerSupportTicket", getRootElement(),
function(kategorie, betreff, text)
	outputChatBox("Nachricht versendet", 0, 255, 0)
	triggerServerEvent("writeTicket", getLocalPlayer(), kategorie, betreff, text)
	
			triggerServerEvent("allowCursor", getLocalPlayer())
			removeEventHandler("onClientBrowserCreated", theSupportWindow, supportEvent)
			guiSetVisible(supportWindow, false)
			variable = 0
			showCursor(false)
			guiSetInputMode("allow_binds")
			guiSetInputEnabled(false)
			
			if isTimer(timerR) then
				killTimer(timerR)
			end
			callBack = false;
end)



-- Auslesen

addEvent("insertIntoSupportTable", true)
addEventHandler("insertIntoSupportTable", getLocalPlayer(),
function(id, topic, bearbeiter, status)
	local String1 = "'"..id.."'"
	local String2 = "'"..topic.."'"
	local String3 = "'"..bearbeiter.."'"
	local String4 = "'"..status.."'"	
	executeBrowserJavascript(theSupportWindow, "makeResultInSupportTable("..String1..","..String2..","..String3..","..String4..")")
end)


addEvent("triggerToServerRead", true)
addEventHandler("triggerToServerRead", getRootElement(),
function(id)
	triggerServerEvent("triggerToClientSupp", getLocalPlayer(), id)
end)



addEvent("writeAnswerIntoInput", true)
addEventHandler("writeAnswerIntoInput", getLocalPlayer(),
function(topic, text, antwort)
	local String1 = "`"..topic.."`"
	local String2 = "`"..text.."`"
	local String3 = "`"..antwort.."`"
	executeBrowserJavascript(theSupportWindow, "inputSetAnswer("..String1..","..String2..","..String3..")")
end)

addEvent("testJavaS", true)
addEventHandler("testJavaS", getRootElement(),
function(topic)
	outputChatBox(topic)
end)


