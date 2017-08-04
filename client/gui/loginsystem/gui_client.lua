local ReState = ""
local width = 0
local text = 0
local screenW, screenH = guiGetScreenSize()
local AufX =  1920
local AufY =  1080
local Ax = screenW/AufX
local Ay = screenH/AufY
local playerNickName = getPlayerName(getLocalPlayer())
local returnBack = false
local checkJavaBack;


setAmbientSoundEnabled( "gunfire", false )

local function StartLoading()
	dxDrawRectangle(757*Ax, 503*Ay, 408*Ax, 74*Ay, tocolor(0, 0, 0, 150), false)
	if width == 388 then
		width = 0
	elseif width < 388 then
		width = width+2
	end
	if text <= 20 then
		text = text+2
		dxDrawText("Bitte habe etwas Geduld", (822 + 1)*Ax, (587 + 1)*Ay, (1164 + 1)*Ax, (618 + 1)*Ay, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Bitte habe etwas Geduld", 822*Ax, 587*Ay, 1164*Ax, 618*Ay, tocolor(255, 255, 255, 255), 2.00, "default", "left", "top", false, false, false, false, false)
	elseif text <= 40 then
		text = text+2
		dxDrawText("Bitte habe etwas Geduld.", (822 + 1)*Ax, (587 + 1)*Ay, (1164 + 1)*Ax, (618 + 1)*Ay, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Bitte habe etwas Geduld.", 822*Ax, 587*Ay, 1164*Ax, 618*Ay, tocolor(255, 255, 255, 255), 2.00, "default", "left", "top", false, false, false, false, false)
	elseif text <= 60 then
		text = text+2
		dxDrawText("Bitte habe etwas Geduld..", (822 + 1)*Ax, (587 + 1)*Ay, (1164 + 1)*Ax, (618 + 1)*Ay, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Bitte habe etwas Geduld..", 822*Ax, 587*Ay, 1164*Ax, 618*Ay, tocolor(255, 255, 255, 255), 2.00, "default", "left", "top", false, false, false, false, false)	
	elseif text <= 80 then
		text = text+2
		if text > 80 then
			text = 0
		end
		dxDrawText("Bitte habe etwas Geduld...", (822 + 1)*Ax, (587 + 1)*Ay, (1164 + 1)*Ax, (618 + 1)*Ay, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Bitte habe etwas Geduld...", 822*Ax, 587*Ay, 1164*Ax, 618*Ay, tocolor(255, 255, 255, 255), 2.00, "default", "left", "top", false, false, false, false, false)
	end
	dxDrawRectangle(767*Ax, 513*Ay, width*Ax, 54*Ay, tocolor(0, 254, 0, 255), false)
end	

addEventHandler("onClientResourceStart", resourceRoot,
function()
	fadeCamera(false, 2)
	triggerServerEvent("checkLoadingServer", getLocalPlayer())
end)

setTimer(
function()
	if ReState == "loading" then
		addEventHandler("onClientRender", getRootElement(), StartLoading)
		fadeCamera(true)
	elseif ReState == "ready" then
		triggerServerEvent("CheckAccount", getLocalPlayer())
	end
end, 2000, 1)
	
setCameraMatrix(1119.9748535156, -1531.6750488281, 29.504173278809, 1198.0433349609, -1480.0128173828, 64.665657043457)
fadeCamera(true)
toggleAllControls(false)

addEvent("startResourceWinLoad", true)
addEventHandler("startResourceWinLoad", getLocalPlayer(),
function(state)
	if state == "loading" then
		ReState = "loading"
		return
	elseif state == "ready" then
		ReState = "ready"
		removeEventHandler("onClientRender", getRootElement(), StartLoading)
		triggerServerEvent("CheckAccount", getLocalPlayer())
	end
end)

addEvent("javaS", true)
addEventHandler("javaS", getRootElement(),
function(name, paw)
	triggerServerEvent("LoginAccount", getLocalPlayer(), name, hash("sha512", paw))
end)

addEvent("javaReg", true)
addEventHandler("javaReg", getRootElement(),
function(name, paw, paw2, email)
	if name == getPlayerName(getLocalPlayer()) then
		if paw ~= paw2 then outputChatBox("Passwörter nicht identisch", 255, 0, 0) return end 
		
		triggerServerEvent("RegisterAccount", getLocalPlayer(), name, hash("sha512", paw), email)
	end
end)

local screenW, screenH = guiGetScreenSize()
local brow = 0
local browser;
local theBrowser;
local nameInside;

function nameInside()
	if source == browser then
		local PlayerText = "'"..playerNickName.."'"
		if var == true then
			executeBrowserJavascript(theBrowser, "setName("..PlayerText..")")
		elseif var == false then
			executeBrowserJavascript(theBrowser, "setNameRegister("..PlayerText..")")
		end
	end
end

--[[

addEvent("ActivateGUI", true)
addEventHandler("ActivateGUI", getLocalPlayer(),
	function(var)
		if var == true then	
			if not (brow == 1) then
				brow = 1
				showCursor(true)
				browser = guiCreateBrowser((screenW-300)/2, (screenH-400)/2, 300, 400, true, false, false)
				theBrowser = guiGetBrowser(browser)
				fadeCamera(true, 0.1)
				addEventHandler("onClientBrowserCreated", theBrowser, 
				function()	
					setTimer(
					function()
						local PlayerText = "'"..getPlayerName(getLocalPlayer()).."'"
						executeBrowserJavascript(theBrowser, "setName("..PlayerText..")")
					end, 1000, 1, source)
					loadBrowserURL(theBrowser, "http://mta/general/client/gui/loginsystem/test.html")
				end)
			end
		elseif var == false then
			if not (brow == 1) then
				brow = 1
				showCursor(true)
				browser = guiCreateBrowser((screenW-300)/2, (screenH-500)/2, 300, 500, true, false, false)
				theBrowser = guiGetBrowser(browser)
				fadeCamera(true, 0.1)
				addEventHandler("onClientBrowserCreated", theBrowser, 
				function()
					if guiGetVisible(browser) then
						loadBrowserURL(theBrowser, "http://mta/general/client/gui/loginsystem/register.html")
						while (returnBack == false) do
							
						nameTimer = setTimer(
						function(player)
							local PlayerText = "'"..playerNickName.."'"
							executeBrowserJavascript(theBrowser, "setNameRegister("..PlayerText..")")
						end, 1000, 1, source)
					else
						return nameTimer
					end
					loadBrowserURL(theBrowser, "http://mta/general/client/gui/loginsystem/register.html")
				end)
			end
		end
		addEventHandler("onClientBrowserDocumentReady", getLocalPlayer(), nameInside)
	end)
	
--]]

local loginTimer;
local login = false;

addEvent("ActivateGUI", true)
addEventHandler("ActivateGUI", getLocalPlayer(),
	function(var)
		if var == true then	
			if not (brow == 1) then
				brow = 1
				showCursor(true)
				browser = guiCreateBrowser((screenW-300)/2, (screenH-400)/2, 300, 400, true, false, false)
				theBrowser = guiGetBrowser(browser)
				fadeCamera(true, 0.1)
				login = true
				addEventHandler("onClientBrowserCreated", theBrowser,
				function()
					loadBrowserURL(theBrowser, "http://mta/general/client/gui/loginsystem/test.html")
					--local PlayerText = "'"..getPlayerName(getLocalPlayer()).."'"
					loginTimer = setTimer(checkJavaBack, 2000, 0)
				end)
			end
		elseif var == false then
			if not (brow == 1) then
				brow = 1
				showCursor(true)
				browser = guiCreateBrowser((screenW-300)/2, (screenH-500)/2, 300, 500, true, false, false)
				theBrowser = guiGetBrowser(browser)
				fadeCamera(true, 0.1)
				addEventHandler("onClientBrowserCreated", theBrowser, 
				function()
					if guiGetVisible(browser) then
						loadBrowserURL(theBrowser, "http://mta/general/client/gui/loginsystem/register.html")
						loginTimer = setTimer(checkJavaBack, 2000, 0)
					end
				end)
			end
		end
	end)

addEvent("returnBackVariable", true)
addEventHandler("returnBackVariable", getRootElement(),
function()
	returnBack = true
end)

function checkJavaBack()
	if returnBack == false then
		if login == true then
			executeBrowserJavascript(theBrowser, "setName(".."'"..playerNickName.."'"..")")
		else
			executeBrowserJavascript(theBrowser, "setNameRegister(".."'"..playerNickName.."'"..")")
		end
	else
		killTimer(loginTimer)
	end
end
	
	
addEvent("Login", true)
addEventHandler("Login", getLocalPlayer(),
function()
	guiSetVisible(browser, false)
	showCursor(false)
	toggleAllControls(true)
	if isTimer(loginTimer) then
		killTimer(loginTimer)
	end
	login = false
	removeEventHandler("onClientBrowserDocumentReady", getLocalPlayer(), nameInside)
end)