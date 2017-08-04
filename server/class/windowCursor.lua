addEvent("allowCursor", true)
addEventHandler("allowCursor", getRootElement(),
function()
	if source == client then
		setPlayerElement(source, "cursor", true)
	end
end)
addEvent("allowNotCursor", true)
addEventHandler("allowNotCursor", getRootElement(),
function()
	if client == source then	
		setPlayerElement(source, "cursor", false)
	end
end)
