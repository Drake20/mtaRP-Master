local losSantos24_7Shop = createPed(44, -26.89999961853, -91.599998474121, 1003.5)
setElementFrozen(losSantos24_7Shop, true)
setElementInterior(losSantos24_7Shop, 18)

local intoShopMarker = createMarker(1834, -1842.5999755859, 13.39999961853, "corona", 1, 95, 254, 0)

local outoShopMarker = createMarker(-30.700000762939, -92.699996948242, 1002.9000244141, "corona", 1, 95, 254, 0)
setElementInterior(outoShopMarker, 18)

addEventHandler("onMarkerHit", intoShopMarker,
function(element)
	if isPedInVehicle(element) then return end
		setElementInterior(element, 18)
		setElementPosition(element, -30.799999237061, -90.599998474121, 1003.5)
end)

addEventHandler("onMarkerHit", outoShopMarker,
function(element)
	if isPedInVehicle(element) then return end
		setElementInterior(element, 0)
		setElementPosition(element, 1832.1999511719, -1842.5999755859, 13.60000038147)
		setElementRotation(element, 0, 0, 90)
end)

addEventHandler("onElementClicked", getRootElement(),
function(mouse, state, player)
	if mouse == "left"  and state == "down" then
		if source == losSantos24_7Shop then
			local x, y , z = getElementPosition(player)
			if getDistanceBetweenPoints3D(x, y, z, -26.89999961853, -91.599998474121, 1003.5) <= 5 then
				triggerClientEvent(player, "createNewWindow", player, "npc_1", nil, nil, 400, 500, true, "http://mta/general/client/shop/shop.html", "fuellTableForShopSystem", true, nil, nil, nil)
			end
		end
	end
end)