local playTimeTable = {}

addEvent("saveTimeInDatabase", true)
addEventHandler("saveTimeInDatabase", getRootElement(),
function()
	if source == client then
		dbExec(handler, "UPDATE payday SET zeit=? WHERE spieler =?;", time, getPlayerName(source))
	end
end)