addEvent("writeTicket", true)
addEventHandler("writeTicket", getRootElement(),
function(kategorie, thema, text)
	if source == client then
		dbExec(handler, "INSERT INTO support (name, kategorie, thema, text) VALUES (?, ?, ?, ?)", getPlayerName(source), kategorie, thema, text)
		if kategorie == "Schnelle Hilfe" then
			for k, v in pairs (AdminTable) do
				outputChatBox("Spieler "..getPlayerName(source).." benötigt schnelle Hilfe!", k, 255, 255, 0)
			end
		elseif kategorie == "Allgemeine Fragen" then
			for k, v in pairs (AdminTable) do
				outputChatBox("Spieler "..getPlayerName(source).." hat eine Frage gestellt!", k, 255, 255, 0)
			end
		end
	end
end)



addEvent("startSupportReadTable", true)
addEventHandler("startSupportReadTable", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM support WHERE name = ?", getPlayerName(source))
			local result = dbPoll(query, -1)
			if result and #result > 0 then
				for k, v in ipairs (result) do
					triggerClientEvent(source, "insertIntoSupportTable", source, v["id"], v["thema"], v["bearbeiter"], v["status"])
				end
			end
	end
end)

addEvent("triggerToClientSupp", true)
addEventHandler("triggerToClientSupp", getRootElement(),
function(id)
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM support WHERE id = ?;", id)
		local result = dbPoll(query, -1)
			if result and #result > 0 then
				if result[1]["antwort"] == "" then
					triggerClientEvent(source, "writeAnswerIntoInput", source, result[1]["thema"], result[1]["text"], "Es gibt noch keine Antwort")
				else
					triggerClientEvent(source, "writeAnswerIntoInput", source, result[1]["thema"], result[1]["text"], result[1]["antwort"])
				end
			else
				dbFree(query)
			end
	end
end)