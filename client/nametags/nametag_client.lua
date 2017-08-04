local distance = 15

addEventHandler("onClientRender", getRootElement(),
function()
	for i, v in ipairs(getElementsByType("player")) do
		if v ~= getLocalPlayer() then
			if not (getElementData(v, "Spy") == 1) then
				local px, py, pz = getPedBonePosition(getLocalPlayer(), 8)
				local vx, vy, vz = getPedBonePosition(v, 8)
				local wx, wy = getScreenFromWorldPosition(vx, vy, vz+0.4)
				local si = 1-getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz)/distance
				if getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz) <= distance then
					if wx then
						dxDrawText(getPlayerName(v), wx, wy, wx, wy, tocolor(255, 255, 255), 2*si, "arial", "center", "center", false, false, false, false, true)
					end
				end
			end
		end
	end
end)