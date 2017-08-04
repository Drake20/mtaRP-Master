createPickup(1800.8000488281, -1883.1999511719, 13.60000038147, 3, 1271, 2000)


local Shape = createColSphere(1800.8000488281, -1883.1999511719, 13.60000038147, 10)


addEventHandler("onColShapeHit", Shape,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not isPedInVehicle(hitElement) then
			outputChatBox("test12")
			triggerClientEvent(hitElement, "startPickUp", hitElement)
		end
	end
end)


addEventHandler("onColShapeLeave", Shape,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not isPedInVehicle(hitElement) then
			triggerClientEvent(hitElement, "startPickUp", hitElement)
		end
	end
end)