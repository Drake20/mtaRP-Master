local screenW, screenH = guiGetScreenSize();
windowTable = {}
local nameW;
local variable = 0;
local callBack = false;
local timerReturn;
local timerR;

addEvent("createNewWindow", true)
addEventHandler("createNewWindow", getLocalPlayer(),
function(name, width, height, aWidth, aHeight, center, url, event, scriptOn, script1, script2, script3, script4)
	if variable == 0 then
		variable = 1
		if center == true then
			windowTable[string.lower(name.."Browser")] = guiCreateBrowser((screenW-aWidth)/2, (screenH-aHeight)/2, aWidth, aHeight, true, false, false)
		else
			windowTable[string.lower(name.."Browser")] = guiCreateBrowser(width, height, aWidth, aHeight, true, false, false)
		end
		windowTable[string.lower("the"..name.."Browser")] = guiGetBrowser(windowTable[string.lower(name.."Browser")])
		triggerServerEvent("allowNotCursor", getLocalPlayer())
		local functionsName = string.lower("functions"..name)
		function functionsName()
			loadBrowserURL(source, url)
			if scriptOn == true then
				if not (script1 == nil) then
					timerR = setTimer(timerReturn, 70, 0, script1)
					if not (event == nil) then
						timerR = setTimer(timerReturn, 70, 0, script1, event)
					end
					return
				end
				if not (script2 == nil) then
					timerR = setTimer(timerReturn, 70, 0, script1, script2)
					if not (event == nil) then
						timerR = setTimer(timerReturn, 70, 0, script1, script2, event)
					end
					return
				end
				if not (script3 == nil) then
					timerR = setTimer(timerReturn, 70, 0, script1, script2, script3)
					if not (event == nil) then
						timerR = setTimer(timerReturn, 70, 0, script1, script2, script3, event)
					end
					return
				end
				if not (event == nil) then
					timerR = setTimer(timerReturn, 70, 0, nil, nil, nil, event)
				end
			end
		end
	addEvent(string.lower("close"..name.."WebWindow"), true)
	addEventHandler(string.lower("close"..name.."WebWindow"), getRootElement(),
	function(var)
		triggerServerEvent("allowCursor", getLocalPlayer())
		removeEventHandler("onClientBrowserCreated", windowTable[string.lower("the"..var.."Browser")], functionsName)
		guiSetVisible(windowTable[string.lower(var.."Browser")], false)
		variable = 0
		showCursor(false)
		guiSetInputEnabled(false)
		
		if isTimer(timerR) then
			killTimer(timerR)
		end
		callBack = false;
	end)	
		addEventHandler("onClientBrowserCreated",windowTable[string.lower("the"..name.."Browser")], functionsName)
		showCursor(true)
		nameW = name
	end
end)

addEvent("callBackResult", true)
addEventHandler("callBackResult", getRootElement(),
function()
	callBack = true
end)

function timerReturn(script1, script2, script3, event)
	if callBack == false then
		executeBrowserJavascript(windowTable[string.lower("the"..nameW.."Browser")], "callBackFunc()")
	elseif callBack == true then
		killTimer(timerR)
		if not (event == nil) then
			triggerServerEvent(event, getLocalPlayer())
		end
		if not (script1 == nil) then
			executeBrowserJavascript(windowTable[string.lower("the"..nameW.."Browser")], script1)
		end
		if not (script2 == nil) then
			executeBrowserJavascript(windowTable[string.lower("the"..nameW.."Browser")], script2)
		end
		if not (script3 == nil) then
			executeBrowserJavascript(windowTable[string.lower("the"..nameW.."Browser")], script3)
		end	
	end
end