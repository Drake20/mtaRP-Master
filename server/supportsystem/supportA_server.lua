addCommandHandler("tickets",
function(player)
	if getAdmin(player) >= 1 then
		triggerClientEvent(player, "openSupportAGui", player)
	end
end)


addEvent("startGridLoadAdmin", true)
addEventHandler("startGridLoadAdmin", getRootElement(),
function()
	if source == client then
		if getAdmin(source) >= 1 then
		local query = dbQuery(handler, "SELECT * FROM support WHERE bearbeitung = ? OR bearbeitung = ?;", 0, 1)
			local result = dbPoll(query, -1)
			if result and #result > 0 then
				for k, v in ipairs (result) do
					triggerClientEvent(source, "insertIntoSuppATable", source, v["id"], v["thema"], v["name"], v["bearbeiter"], v["status"])
				end
			else
				dbFree(query)
				outputChatBox("Es sind momentan keine Tickets offen :(", source, 255, 0, 0)
			end
		end
	end
end)

local moreOpenTickets;

addEvent("giveAdminTicket", true)
addEventHandler("giveAdminTicket", getRootElement(),
function(id)
	if source == client then
		if getAdmin(source) >= 1 then
		local query = dbQuery(handler, "SELECT * FROM support WHERE id = ?", id)
		local query2 = dbQuery(handler, "SELECT * FROM support WHERE bearbeiter = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		local result2 = dbPoll(query2, -1)
			if result and #result == 1 and result2 then
				if result[1]["bearbeitung"] == 0 then 
					for k, v in ipairs (result2) do
						if v["bearbeitung"] == 1 then
							outputChatBox("Du hast bereits ein Ticket!", source, 255, 0, 0)
							moreOpenTickets = 1
							break
						end
					end
					if moreOpenTickets == 1 then moreOpenTickets = 0 return end
					dbExec(handler, "UPDATE support SET bearbeiter = '"..getPlayerName(source).."', status = ?, bearbeitung = ?  WHERE id = '"..id.."'", "bearbeitung", 1)
					outputChatBox("Du hast dir Ticket ID "..id.." zugewiesen!", source, 0, 255, 0)
					triggerClientEvent(source, "insertIntoInputsSupp", source, result[1]["thema"], result[1]["text"])
					triggerClientEvent(source, "refreshTicketsForSuppFromServer", source)
				else
					outputChatBox("Das Ticket ist schon vergeben!", source, 255, 0, 0)
				end
			end
		end
	end					
end)

addEvent("takeTicketServer", true)
addEventHandler("takeTicketServer", getRootElement(),
function()
	if source == client then
		if getAdmin(source) >= 1 then
		local query = dbQuery(handler, "SELECT * FROM support WHERE bearbeiter = ? AND bearbeitung = ?;", getPlayerName(source), 1)
		local result = dbPoll(query, -1)
			if result and #result > 0 then
				dbExec(handler, "UPDATE support SET bearbeiter = ? , status = ?, bearbeitung = ? WHERE id = ?;", "keiner", "offen", 0, result[1]["id"])
				outputChatBox("Du hast das Ticket mit der ID "..result[1]["id"].." von "..result[1]["name"].." verlassen", source, 255, 0, 0)
				triggerClientEvent(source, "refreshTicketsForSuppFromServer", source)
			else
				dbFree(query)
				outputChatBox("Du besitz momentan kein Ticket!", source, 255, 0, 0)
			end
		end
	end
end)


addEvent("sendTicketAnswer", true)
addEventHandler("sendTicketAnswer", getRootElement(),
function(topic, answer)
	if source == client then
		if getAdmin(source) >= 1 then
			local query = dbQuery(handler, "SELECT * FROM support WHERE thema = ? AND bearbeiter = ?;", topic, getPlayerName(source))
			local result = dbPoll(query, -1)
			if result and #result > 0 then
				if result[1]["bearbeiter"] == getPlayerName(source) then
					dbExec(handler, "UPDATE support SET status = ? , antwort = ?, bearbeitung = 2 WHERE id = ?;", "geschlossen", answer, result[1]["id"])
					outputChatBox("Du hast das Ticket ID "..result[1]["id"].." beantwortet und geschlossen", source, 0, 255, 0)
					if not (getPlayerFromName(result[1]["name"]) == false) then
						outputChatBox("Dein Ticket ID "..result[1]["id"].." wurde von "..result[1]["bearbeiter"].." beantwortet.\nGebe /report ein um die Nachricht zu lesen.", getPlayerFromName(result[1]["name"]), 0, 255, 0)
						playSoundFrontEnd(getPlayerFromName(result[1]["name"]), 40)
						triggerClientEvent(source, "refreshTicketsForSuppFromServer", source)
					end
				end
			else
				dbFree(query)
				outputChatBox("Du hast dir kein Ticket zugewiesen!", source, 255, 0, 0)
			end
		end
	end
end)