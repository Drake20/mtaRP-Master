local normalChatRadius = 15

addEventHandler("onPlayerChat", getRootElement(),
function(message, typ)
	cancelEvent()
	
	if typ == 0 then
		local x, y, z = getElementPosition(source)
		local Shape = createColSphere(x, y, z, normalChatRadius)
		local uPlayers = getElementsWithinColShape(Shape, "player")
		destroyElement(Shape)
		
		for i, p in ipairs (uPlayers) do
			outputChatBox(getPlayerName(source).." sagt: "..message, p)
		end
	end
end)