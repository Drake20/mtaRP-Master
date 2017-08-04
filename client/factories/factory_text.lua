local function writeText()
	local px, py, pz = getElementPosition(getLocalPlayer())
	local x, y = getScreenFromWorldPosition(1800.8000488281, -1883.1999511719, 13.60000038147+1)
	local si = 1-getDistanceBetweenPoints3D(px, py, pz, 1800.8000488281, -1883.1999511719, 13.60000038147+1)/15
	if getDistanceBetweenPoints3D(px, py, pz, 1800.8000488281, -1883.1999511719, 13.60000038147+1) <= 15 then
		if x then
			dxDrawText("Privates Unternehmen\nvon Drake", x, y, x, y, tocolor(0, 0, 0), 4*si, "arial", "center", "center", false, false, false, false, true)
		end
	end
end

local state = 0

addEvent("startPickUp", true)
addEventHandler("startPickUp", getLocalPlayer(),
function()
	if state == 0 then
		addEventHandler("onClientRender", getRootElement(), writeText)
		state = 1
	elseif state == 1 then
		removeEventHandler("onClientRender", getRootElement(), writeText)
		state = 0
	end
end)