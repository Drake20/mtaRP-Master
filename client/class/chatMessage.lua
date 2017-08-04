local screenW, screenH = guiGetScreenSize()
local messageTimer;
local renderTheMessage;
local timeL, messageL, rL, bL, gL;

addEvent("startMessage", true)
addEventHandler("startMessage", getLocalPlayer(),
function(time, message, r, g, b)
    if isTimer(messageTimer) == false then
		
		timeL = time 
		messageL = message
		rL = r
		gL = g
		bL = b
		
		addEventHandler("onClientRender", root, renderTheMessage)
		playSoundFrontEnd (40)   
		messageTimer = setTimer(
		function()
			removeEventHandler("onClientRender", root, renderTheMessage)
		end, time, 1)
	else
		removeEventHandler("onClientRender", root, renderTheMessage)
		if isTimer(messageTimer) then
			killTimer(messageTimer)
		end
			triggerEvent("startMessage", getLocalPlayer(), time, message, r, g, b)
			return
	end
end)



function renderTheMessage()
	dxDrawRectangle(50, screenH / 2, 265, 40, tocolor(1, 1, 0, 170), false)
	dxDrawText(messageL, 50, (screenH+25) / 2, 1919, 554, tocolor(rL, gL, bL, 255), 1.00, "default", "left", "top", false, false, false, false, false)
end