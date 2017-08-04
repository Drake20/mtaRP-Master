handler = dbConnect( "mysql", "dbname=customer1278_mta;host=37.114.62.75", "custo_mmta", "Zzui15?2")
local t = getRealTime()
local timenow = t.timestamp
		
if handler then
	outputDebugString("Datenbankverbindung erfolgreich", 3, 0, 255, 0)
else
	outputDebugString("Datenbankverbindung fehlgeschlagen", 3, 255, 255, 0)
	stopResource(getThisResource())
	outputDebugString("Resource "..getResourceName(getThisResource()).." wurde gestoppt! (Database is missing)", 3, 255, 255, 0)
end

addEventHandler("onResourceStart",resourceRoot,
function()
	local query = dbQuery(handler, "SELECT * FROM system")
	local result = dbPoll(query, -1)
	if result and #result == 1 then
		setServerPassword(result[1]["password"])
		setGameType(result[1]["gamemode"])
		setMapName(result[1]["mapname"])
		setMaxPlayers(result[1]["slots"])
		setFPSLimit(result[1]["fpslimit"])
		outputDebugString("Alle Settings wurden angepasst", 3, 255, 255, 0)
	else
		dbFree(query)
		stopResource(getThisResource())
		outputDebugString("Resource "..getResourceName(getThisResource()).." wurde gestoppt (System Datenbank)!", 3, 255, 255, 0)
	end
end)