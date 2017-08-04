local vari = {}
local timeCount;
local insertTimeIntoDatabase;
local playTimeTable = {}

addEvent("LoginAccount", true)
addEventHandler("LoginAccount", getRootElement(),
function(spieler, passw)
	if (client == source) then	
		if not (vari[source] == 1) then
			vari[source] = 1
			local pw = passw
			local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = ? AND passwort =?;", spieler, passw)
			local queryO = dbQuery(handler, "SELECT * FROM omessage WHERE spieler = '"..spieler.."'")
			local queryEco = dbQuery(handler, "SELECT * FROM payday WHERE spieler = ?;", getPlayerName(source))
			local result, num_rows = dbPoll(query, -1)
			local resultO = dbPoll(queryO, -1)
			local resultEco = dbPoll(queryEco, -1)
			if (result) and (num_rows >0) then
				triggerClientEvent(source, "startMessage", source, 3000, "Willkommen zurück", 255, 255, 255)
				triggerClientEvent(source, "Login", source)
				
				if result[1]["intro"] == 0 then
					fadeCamera(source, false, 2)
					triggerClientEvent(source, "startClientIntro", source)
				elseif result[1]["intro"] == 1 then
					spawnPlayer(source, 1742.6999511719, -1860.5999755859, 13.60000038147, 0, result[1]["skin"])
					setCameraTarget(source, source)
				else
					kickPlayer(source, "System", "Error #962") -- intro Spalte nicht vorhanden
				end
				if result[1]["fraktion"] == 1 then
				end
				if result[1]["admin"] >= 1 then
					setAdmin(source, result[1]["admin"])
				end
				setPlayerElement(source, "bikeLicence",	tonumber(gettok(result[1]["licences"], 1, string.byte('|'))))
				setPlayerElement(source, "carLicence", tonumber(gettok(result[1]["licences"], 2, string.byte('|'))))
				setPlayerElement(source, "lkwLicence", tonumber(gettok(result[1]["licences"], 3, string.byte('|'))))
				setPlayerElement(source, "busLicence", tonumber(gettok(result[1]["licences"], 4, string.byte('|'))))
				setPlayerElement(source, "tractorLicence", tonumber(gettok(result[1]["licences"], 5, string.byte('|'))))
				setPlayerElement(source, "chopperLicence", tonumber(gettok(result[1]["licences"], 6, string.byte('|'))))
				setPlayerElement(source, "flight1Licence", tonumber(gettok(result[1]["licences"], 7, string.byte('|'))))
				setPlayerElement(source, "flight2Licence", tonumber(gettok(result[1]["licences"], 8, string.byte('|'))))
				setPlayerElement(source, "boatLicence", tonumber(gettok(result[1]["licences"], 9, string.byte('|'))))
				setPlayerNametagShowing(source, false)
			else
				dbFree(query)
				outputChatBox("Falsches Passwort", source, 255, 0, 0)
				vari[source] = 0
			end
			if resultO and #resultO == 1 then
				for k, v in ipairs (resultO) do
					outputChatBox("[Admin] Offline-Nachricht von "..v["admin"]..": "..v["message"], player, 0, 255, 255)
				end
				dbExec(handler, "DELETE FROM omessage WHERE spieler = '"..spieler.."'")
			else
				dbFree(queryO)
			end
			if resultEco == nil then
				dbFree(queryEco)
			end
			if resultEco and #resultEco > 0 then
				setPlayerElement(source, "economyPlayTime", resultEco[1]["zeit"])
				playTimeTable[source] = setTimer(timeCount, 60000, 0, source)
			end
		end
	else
		vari[source] = nil
		kickPlayer(source, "System", "Sicherheit Error #14") -- Source nicht Client| Error #14
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if playTimeTable[player] then
		killTimer(playTimeTable[source])
		playTimeTable[player] = nil
	end
end)

function timeCount(player)
	if playTimeTable[player] then
		local time = getPlayerElement(player, "economyPlayTime")
		setPlayerElement(player, "economyPlayTime", time+1)
		dbExec(handler, "UPDATE payday SET zeit=? WHERE spieler =?;", time, getPlayerName(player))
	end
end