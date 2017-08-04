-- Statistiken


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	local query = dbQuery(handler, "SELECT spieler FROM users")
	local result, rows = dbPoll(query, -1)
	if result then 
		if rows > 0 then
			outputServerLog("[Statistik] Es sind "..rows.." Spieler vorhanden")
		else
			outputServerLog("[Statistik] Es sind keine Spieler vorhanden")
		end
	end
end)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	local query = dbQuery(handler, "SELECT spieler FROM tbans")
	local result, rows = dbPoll(query, -1)
	if result then 
		if rows > 0 then
			outputServerLog("[Statistik] Es sind "..rows.." Spieler zeitlich gebannt")
		else
			outputServerLog("[Statistik] Es sind keine Spieler zeitlich gebannt")
		end
	end
end)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	local query = dbQuery(handler, "SELECT id FROM vehicles")
	local result, rows = dbPoll(query, -1)
	if result then 
		if rows > 0 then
			outputServerLog("[Statistik] Es sind "..rows.." Fahrzeuge vorhanden")
		else
			outputServerLog("[Statistik] Es sind keine Fahrzeuge vorhanden")
		end
	end
end)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
function()
	local query = dbQuery(handler, "SELECT id FROM support")
	local result, rows = dbPoll(query, -1)
	if result then 
		if rows > 0 then
			outputServerLog("[Statistik] Es sind "..rows.." Tickets vorhanden")
		else
			outputServerLog("[Statistik] Es sind keine Tickets vorhanden")
		end
	end
end)
	


