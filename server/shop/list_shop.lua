addEvent("fuellTableForShopSystem", true)
addEventHandler("fuellTableForShopSystem", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM shop")
		local result = dbPoll(query, -1)
		triggerClientEvent(source, "fillTableKategorieShop", source, "ID", "Name", "Preis")
		if result then
			if #result > 0 then
				for k, v in ipairs(result) do
					triggerClientEvent(source, "fillTheColumnsFromShop", source, v["id"], v["name"], v["preis"])
				end
			end
		else
			dbFree(query)
		end
	end
end)