
--Deklaration

local screenW, screenH = guiGetScreenSize();
local variable = 0;
local callBack = false;
local timerReturn;
local timerR;
local supportAdminWindow;
local theSupportAdminWindow;
local supportEvent;
local url;

addEvent("openSupportAGui", true)
addEventHandler("openSupportAGui", getLocalPlayer(),
function()
	if variable == 0 then
		variable = 1
		supportAdminWindow = guiCreateBrowser((screenW-900)/2, (screenH-700)/2, 900, 700, true, false, false)
		theSupportAdminWindow = guiGetBrowser(supportAdminWindow)
		triggerServerEvent("allowNotCursor", getLocalPlayer())
		url = "http://mta/general/client/supportsystem/supportReadAdmin.html"
		guiSetInputMode("no_binds")
		function supportEvent()
			loadBrowserURL(theSupportAdminWindow, url)
			timerR = setTimer(timerReturn, 70, 0)
		end
		addEvent("closeSupportGUI", true)
		addEventHandler("closeSupportGUI", getRootElement(),
		function()
			triggerServerEvent("allowCursor", getLocalPlayer())
			removeEventHandler("onClientBrowserCreated", theSupportAdminWindow, supportEvent)
			guiSetVisible(supportAdminWindow, false)
			variable = 0
			showCursor(false)
			guiSetInputMode("allow_binds")
			guiSetInputEnabled(false)
			
			if isTimer(timerR) then
				killTimer(timerR)
			end
			callBack = false;
		end)	
		addEventHandler("onClientBrowserCreated", theSupportAdminWindow, supportEvent)
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
		executeBrowserJavascript(theSupportAdminWindow, "callBackFuncSupp()")
	elseif callBack == true then
		killTimer(timerR)
		triggerServerEvent("startGridLoadAdmin", getLocalPlayer())
	end
end

-- Auslesen

addEvent("insertIntoSuppATable", true)
addEventHandler("insertIntoSuppATable", getLocalPlayer(),
function(id, topic, author, bearbeiter, status)
	local String1 = "'"..id.."'"
	local String2 = "'"..topic.."'"
	local String3 = "'"..author.."'"	
	local String4 = "'"..bearbeiter.."'"
	local String5 = "'"..status.."'"	
	executeBrowserJavascript(theSupportAdminWindow, "makeResultTable("..String1..","..String2..","..String3..","..String4..","..String5..")")
end)

-- Zuweisung
addEvent("giveAdminTheTicket", true)
addEventHandler("giveAdminTheTicket", getRootElement(),
function(id)
	triggerServerEvent("giveAdminTicket", getLocalPlayer(), id)
end)

addEvent("takeTicketFromSupp", true)
addEventHandler("takeTicketFromSupp", getRootElement(),
function(id)
	triggerServerEvent("takeTicketServer", getLocalPlayer())
end)

addEvent("refreshTicketsForSupp", true)
addEventHandler("refreshTicketsForSupp", getRootElement(),
function()
	triggerServerEvent("startGridLoadAdmin", getLocalPlayer())
end)

addEvent("sendSuppQuestionBack", true)
addEventHandler("sendSuppQuestionBack", getRootElement(),
function(topic, answer)
	triggerServerEvent("sendTicketAnswer", getLocalPlayer(), topic, answer)
end)


addEvent("refreshTicketsForSuppFromServer", true)
addEventHandler("refreshTicketsForSuppFromServer", getLocalPlayer(),
function()
	executeBrowserJavascript(theSupportAdminWindow, "refreshList()")
end)




addEvent("insertIntoInputsSupp", true)
addEventHandler("insertIntoInputsSupp", getLocalPlayer(),
function(topic, question)	
	local String1 = "`"..topic.."`"
	local String2 = "`"..question.."`"
	executeBrowserJavascript(theSupportAdminWindow, "inputSetUserQuestion("..String1..","..String2..")")
end)

