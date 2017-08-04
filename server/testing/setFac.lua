addEventHandler("onResourceStart", resourceRoot,
function()
	local fraktionen = Factionen:Constructor()
	local query = dbQuery(handler, "SELECT * FROM fraktionen")
	local result = dbPoll(query, -1)
	if #result > 0 then
		for k, v in ipairs (result) do
			fraktionen:add(police:Constructor())
		end
		outputChatBox(fraktionen.fraktionen[1], getRootElement())
		if fraktionen:Count() == 0 then
			outputDebugString("Es wurde keine Fraktion erstellt!", 3, 0, 255, 0)
		elseif fraktionen:Count() == 1 then
			outputDebugString("Eine Fraktion wurde erstellt!", 3, 0, 255, 0)
		elseif fraktionen:Count() > 1 then
			outputDebugString(fraktionen:Count().." Fraktionen wurden erstellt!", 3, 0, 255, 0)
		end
	end
end)