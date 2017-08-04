--[[
	(c) Drake 
	Date: 10.08.2016
--]]

addEvent("CheckAccount", true)
addEventHandler("CheckAccount", getRootElement(),
	function()
		if (client == source) then
			local query = dbQuery(handler, "SELECT * FROM users WHERE spieler ='"..getPlayerName(source).."'")
			local result, num_rows = dbPoll(query, -1)
			if (result) and (num_rows > 0) then
				triggerClientEvent(source, "ActivateGUI", source, true)
			else
				triggerClientEvent(source, "ActivateGUI", source, false)
			end
		else
			kickPlayer(source, "System", "Sicherheit Error #14") -- Source nicht Client Error #14
		end
	end)
	
addEvent("RegisterAccount", true)
addEventHandler("RegisterAccount", getRootElement(),
function(spieler, passwort_1, email)
	if (client == source) then --'"..spieler.."', '"..passwort_1.."', '"..getPlayerSerial(source)"', '"..email.."')
		dbExec(handler, "INSERT INTO users (spieler, passwort, serial, email) VALUES (?, ?, ?, ?)", spieler, passwort_1, getPlayerSerial(source), email)
		redirectPlayer(source, "localhost", "22003")
	end
end)