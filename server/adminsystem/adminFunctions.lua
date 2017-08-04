-- Admin Rang Info
-- Rang 1 Supporter
-- Rang 2 Administrator
-- Rang 3 stellv. Servermanager
-- Rang 4 Servermanager

AdminTable = {}
local Notfall = {}
local NotfallT = {}
local Eventmode = {}
local air = {}
local Spec = {
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = ""
}

function setAdmin(player, level)
	if AdminTable[player] == nil then
		AdminTable[player] = level
	end
end

function getAdmin(name)
	if AdminTable[name] == nil then
		return 0
	else
		return AdminTable[name]
	end
end

addCommandHandler("acommands",
function(player)
	if getAdmin(player) >= 1 then
		outputConsole("/a [Text] | Interner Adminchat", player)
		outputConsole("/akick [Name] [Grund] | Einen Spieler kicken", player)
		outputConsole("/aban [Name] [Grund] | Einen Spieler permanent bannen", player)
		outputConsole("/aunban [Name] | Einen permanenten Bann aufheben", player)
		outputConsole("/atban [Name] [Zeit] [Grund] | Einen Spieler temporär bannen", player)
		outputConsole("/autnban [Name] | Einen Zeitbann aufheben", player)
		outputConsole("/tpto [Name] | Zu einem Spieler teleportieren", player)
		outputConsole("/tphere [Name] | Einen Spieler zu sich teleportieren", player)
		outputConsole("/notfall | Den Server herunterfahren 2x bestätigen", player)
		outputConsole("/rstart [Zeit] | Den Server neustarten von 0 - 59 Minuten", player)
		outputConsole("/eventmode | Den Eventmodus aktivieren", player)
		outputConsole("/e [Text] | Im Eventmodus schreiben", player)--
		outputConsole("/afreeze [Name] | Spieler einfrieren oder auftauen", player)
		outputConsole("/support | In den Support schalten (NUR FÜR SUPPORT)", player)
		outputConsole("/aspy [Name] | Spieler beobachten", player)
		outputConsole("/air | Aktiviert den Luftmodus", player)
		outputConsole("/amessage [Name] [Text] | Schickt einem Spieler eine private Nachricht", player)
		outputConsole("/ticket | Öffnet das Supportsystem", player)
	end
end)

addCommandHandler("a",
function (player, cmd, ...)
	local admin = ""
	if getAdmin(player) >= 1 then
		if not (... == nil) then
			if getAdmin(player) == 1 then
				admin = "Supporter"
			elseif getAdmin(player) == 2 then
				admin = "Administrator"
			elseif getAdmin(player) == 3 then
				admin = "stellv. Servermanager"
			elseif getAdmin(player) == 4 then
				admin = "Servermanager"
			end
			local text = table.concat({...}, " ")
			for k, v in pairs(AdminTable) do
				
				outputChatBox("[Intern] "..admin.." "..getPlayerName(player)..": "..text, k)
			end
		else
			outputChatBox("Verwende /a Text", player, 255, 0, 0)
		end
	end
end)

addCommandHandler("akick",
function(player, cmd, target, ...)
	local reas = table.concat( {...}, " ")
	if getAdmin(player) >= 1 then
		if target == nil or getPlayerFromName(target) == false then outputChatBox("Der Spieler ist nicht online!", player, 255, 0, 0) return end
			if ... == nil then outputChatBox("Gebe einen Grund an!", player, 255, 0, 0) return end
				kickPlayer(getPlayerFromName(target), getPlayerName(player), reas)
				outputChatBox("Du hast Spieler "..target.." vom Server geworfen!", player, 0, 255, 0)
				outputChatBox("Spieler "..target.." wurde vom Server geworfen!", getRootElement(), 255, 255, 255)
	end
end)


addCommandHandler("aban", 
function(player, cmd, target, ...)
	local reas = table.concat( {...}, " ")
	if getAdmin(player) >= 1 then
		if target == nil then outputChatBox("Gebe einen Spieler an!", player, 255, 0, 0) return end
			if ... == nil then outputChatBox("Gebe einen Grund an!", player, 255, 0, 0) return end	
				local CheckPBan = dbQuery(handler, "SELECT id FROM bans WHERE spieler = '"..target.."'")
				local CheckPResult = dbPoll(CheckPBan, -1)
				if CheckPResult and #CheckPResult == 0 then		
					if getPlayerFromName(target) == false then
						local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = '"..target.."'")
						local result, num_rows = dbPoll(query, -1)
						if (result) and (num_rows > 0) then
							dbExec(handler, "INSERT INTO bans (spieler, grund, admin, serial) VALUES (?, ?, ?, ?)", target, reas, getPlayerName(player), result[1]["serial"])
							outputChatBox("Du hast Spieler "..target.." permanent gebannt!", player, 0, 255, 0)
						else
							dbFree(query)
							outputChatBox("Der Spieler "..target.." ist weder online, noch in der Datenbank!", player, 255, 0, 0)
						end
					else
						dbExec(handler, "INSERT INTO bans (spieler, grund, admin, serial) VALUES (?, ?, ?, ?)", target, reas, getPlayerName(player), getPlayerSerial(getPlayerFromName(target)))
						outputChatBox("Du hast Spieler "..target.." permanent gebannt!", player, 0, 255, 0)
						kickPlayer(getPlayerFromName(target), getPlayerName(player), reas)
						outputChatBox("Spieler "..target.." wurde vom Server geworfen!", getRootElement(), 255, 255, 255)
					end
				else
					dbFree(CheckPBan)
					outputChatBox("Der Spieler ist bereits permantent gebannt!", player, 255, 0, 0)
				end
	end
end)

addCommandHandler("aunban",
function(player, cmd, target)
	if getAdmin(player) >= 3 then
		if not (target == nil) then
			if getPlayerFromName(target) == false then
				local spieler = getPlayerFromName(target)
				local query = dbQuery(handler, "SELECT * FROM bans WHERE spieler = '"..target.."'")
				local result = dbPoll(query, -1)
				if result and #result == 1 then
					dbExec(handler, "DELETE FROM bans WHERE spieler = '"..target.."'")
					outputChatBox("Du hast Spieler "..target.." entbannt!", player, 0, 255, 0)
				else
					dbFree(query)
					outputChatBox("Der Spieler "..target.." ist nicht gebannt.", player, 255, 0, 0)
				end
			else
				outputChatBox("Verwende /unban Name", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /unban Name", player, 255, 0, 0)
		end
	end
end)


addCommandHandler("atban", 
function(player, cmd, target, hour, ...)
	local reas = table.concat( {...}, " ")
	if getAdmin(player) >= 1 then
		if target == nil then outputChatBox("Gebe einen Spieler an!", player, 255, 0, 0) return end
			if hour == nil then outputChatBox("Gebe eine Zeit an!", player, 255, 0, 0) return end
				if not tonumber(hour) then outputChatBox("Gebe eine Zeit an!", player, 255, 0, 0) return end
					if ... == nil then outputChatBox("Gebe einen Grund an!", player, 255, 0, 0) return end	
						local cur_time = getRealTime()
						local c2_time = (cur_time.timestamp)
						local final_time = c2_time+hour*3600
							if getPlayerFromName(target) == false then
								local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = '"..target.."'")
								local result, num_rows = dbPoll(query, -1)
								if (result) and (num_rows > 0) then
									local CheckPermBan = dbQuery(handler, "SELECT id FROM bans WHERE spieler = '"..target.."'")
									local ResultPerm = dbPoll(CheckPermBan, -1)
									if ResultPerm and #ResultPerm == 0 then
										local CheckBans = dbQuery(handler, "SELECT * FROM tbans WHERE spieler = '"..target.."'")
										local CheckResult = dbPoll(CheckBans, -1)								
										if CheckResult and #CheckResult > 0 then
											dbExec(handler, "UPDATE tbans SET zeit = '"..(CheckResult[1]["zeit"]+(hour*3600)).."', grund = '"..reas.."', admin = '"..getPlayerName(player).."', stunden = '"..(CheckResult[1]["stunden"]+(hour)).."'")
											outputChatBox("Du hast den Bann von "..target.." für "..hour.." verlängert mit der Begründung: "..reas, player, 0, 255, 0)
										else
											dbExec(handler, "INSERT INTO tbans (spieler, admin, grund, stunden, zeit) VALUES (?, ?, ?, ?, ?)", target,getPlayerName(player), reas, hour, final_time)
											outputChatBox("Du hast Spieler "..target.." für "..hour.." Stunden gebannt!", player, 0, 255, 0)
										end
									else
										dbFree(CheckPermBan)
										outputChatBox("Der Spieler ist bereits permanent gebannt!", player, 255, 0, 0)
										return
									end
								else
									dbFree(query)
									outputChatBox("Der Spieler "..target.." ist weder online, noch in der Datenbank!", player, 255, 0, 0)
								end
							else
								dbExec(handler, "INSERT INTO tbans (spieler, admin, grund, stunden, zeit) VALUES (?, ?, ?, ?, ?)", target,getPlayerName(player), reas, hour, final_time)
								outputChatBox("Du hast Spieler "..target.." für "..hour.." Stunden gebannt!", player, 0, 255, 0)
								kickPlayer(getPlayerFromName(target), getPlayerName(player), reas)
								outputChatBox("Spieler "..target.." wurde vom Server geworfen!", getRootElement(), 255, 255, 255)
							end
	end
end)


addCommandHandler("auntban",
function(player, cmd, target)
	if getAdmin(player) >= 3 then
		if not (target == nil) then
			if getPlayerFromName(target) == false then
				local spieler = getPlayerFromName(target)
				local query = dbQuery(handler, "SELECT * FROM tbans WHERE spieler = '"..target.."'")
				local result = dbPoll(query, -1)
				if result and #result == 1 then
					dbExec(handler, "DELETE FROM tbans WHERE spieler = '"..target.."'")
					outputChatBox("Du hast Spieler"..target.." entbannt!", player, 0, 255, 0)
				else
					dbFree(query)
					outputChatBox("Der Spieler "..target.." ist nicht gebannt.", player, 255, 0, 0)
				end
			else
				outputChatBox("Verwende /untban Name", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /untban Name", player, 255, 0, 0)
		end
	end
end)



addCommandHandler("tpto",
function(player, cmd, target)
	if getAdmin(player) >= 1 then
		if not (target == nil) then
			if not (getPlayerFromName(target) == false) then
				local x,y,z = getElementPosition(getPlayerFromName(target))
				if getPedOccupiedVehicle(player) then
					setElementPosition(getPedOccupiedVehicle(player), x, (y)-5, z)
					outputChatBox("Du hast dich zu "..target.." teleportiert!", player, 0, 255, 0)
				else
					setElementPosition(player, x, (y)-5, z)
					outputChatBox("Du hast dich zu "..target.." teleportiert!", player, 0, 255, 0)
				end
			else
				outputChatBox("Der Spieler ist nicht online!", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /tpto Spieler", player, 255, 0, 0)
		end
	end
end)

addCommandHandler("tphere",
function(player, cmd, target)
	if getAdmin(player) >= 1 then
		if not (target == nil) then
			if not (getPlayerFromName(target) == false) then
				local x,y,z = getElementPosition(player)
				if getPedOccupiedVehicle(getPlayerFromName(target)) then
					setElementPosition(getPedOccupiedVehicle(getPlayerFromName(target)), x, (y)-5, z)
					outputChatBox("Du hast "..target.." zu dir teleportiert!", player, 0, 255, 0)
				else
					setElementPosition(getPlayerFromName(target), x, (y)-5, z)
					outputChatBox("Du hast "..target.." zu dir teleportiert!", player, 0, 255, 0)
				end
			else
				outputChatBox("Der Spieler ist nicht online!", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /tpto Spieler", player, 255, 0, 0)
		end
	end
end)

addCommandHandler("notfall",
function(player)
	if getAdmin(player) >= 2 then
		if Notfall[player] == 1 then
			Notfall[player] = nil
			killTimer(NotfallT[player])
			shutdown ("Notfallabschaltung von "..getPlayerName(player))
			return
		end
		if Notfall[player] == nil then
			Notfall[player] = 1
			outputChatBox("Bestätige deine Entscheidung durch /notfall erneut. Ansonsten wird es nach 2 Min automatisch verworfen", player, 255, 0, 0)
			NotfallT[player] = setTimer(
			function()
				Notfall[player] = nil
			end, 120000, 1)
				return
		end
	end
end)


addCommandHandler("rstart", 
function(player, cmd, zeit)
	if getAdmin(player) >= 3 then
		if not (zeit == nil) then
			if tonumber(zeit) then
				if tonumber(zeit) < 60 then
					outputChatBox("Du hast einen neustart ausgelöst!", player, 0, 255, 0)
					outputDebugString(getPlayerName(player).." hat einen Serverneustart ausgeführt!", 3, 0, 255, 0)
					setTimer(
					function()
						for k, v in ipairs (getElementsByType("player")) do
							kickPlayer(v, "Serverrestart!")
						end
						restartResource(getThisResource())
					end, 60000*zeit, 1)
					outputChatBox("Der Server wird in "..zeit.." Minuten neu gestartet!", getRootElement())
					if zeit*60000 > 60000 then
						setTimer(
						function()
							outputChatBox("Der Server wird in 1 Minute neu gestartet!", getRootElement())
						end, (60000*zeit)-60000, 1)
					end
				else
					outputChatBox("Du kannst maximal 60 Min einstellen!", player, 255, 0, 0)
				end
			else
				outputChatBox("Verwende /rstart Minute(n)!", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /rstart Minute(n)!", player, 255, 0, 0)
		end
	end
end)

addCommandHandler("eventmode",
function(player)
	if getAdmin(player) >= 2 then
		if Eventmode[player] == 1 then
			Eventmode[player] = nil
			outputChatBox("Eventmodus beendet!", player, 255, 0, 0)
			outputChatBox("Das Event wurde beendet!", getRootElement(), 0, 255, 255)
		elseif Eventmode[player] == nil then
			Eventmode[player] = 1
			outputChatBox("Du hast den Eventmodus aktiviert!", player, 0, 255, 0)
			outputChatBox("Ein Event wurde gestartet. Weitere Infos folgen!", getRootElement(), 0, 255, 255)
		end
	end
end)


addCommandHandler("e",
function(player, cmd, ...)
	if getAdmin(player) >= 2 then
		if Eventmode[player] == 1 then
			if not (... == nil) then
				local Text = table.concat({...}, " ")
				outputChatBox("[Eventmanager] "..getPlayerName(player)..": "..Text, getRootElement(), 0, 255, 255)
			else
				outputChatBox("Verwende /e Text | Aktiviere aber vorher den Eventmodus!", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /e Text | Aktiviere aber vorher den Eventmodus!", player, 255, 0, 0)
		end
	end
end)


addCommandHandler("afreeze",
function(player, cmd, target)
	if getAdmin(player) >= 1 then
		if not (target == nil) then
			if not (getPlayerFromName(target) == false) then
				local spieler = getPlayerFromName(target)
				if isElementFrozen(spieler) == true then
					setElementFrozen(spieler, false)
					if not (getPedOccupiedVehicle(spieler) == false) then
						if isElementFrozen(getPedOccupiedVehicle(spieler)) == true then
							setElementFrozen(getPedOccupiedVehicle(spieler), false)
						end
					end
					outputChatBox("Du hast Spieler"..target.." aufgetaut!", player, 0, 255, 0)
					outputChatBox("[SYSTEM] Du wurdest von "..getPlayerName(player).." aufgetaut!", spieler, 255, 0, 0)
				elseif isElementFrozen(spieler) == false then
					setElementFrozen(spieler, true)
					if not (getPedOccupiedVehicle(spieler) == false) then
						if isElementFrozen(getPedOccupiedVehicle(spieler)) == false then
							setElementFrozen(getPedOccupiedVehicle(spieler), true)
						end
					end
					outputChatBox("Du hast Spieler"..target.." eingefroren!", player, 0, 255, 0)
					outputChatBox("[SYSTEM] Du wurdest von "..getPlayerName(player).." eingefroren!", spieler, 255, 0, 0)
				end
			else
				outputChatBox("Verwende /afreeze Name", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /afreeze Name", player, 255, 0, 0)
		end
	end
end)

addCommandHandler("aset",
function(player, cmd, target, DBsatz, wert)
	if getAdmin(player) >= 3 then
		if not (target == nil) then
			if not (DBsatz == nil) then
				if not (wert == nil) then
					local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = '"..target.."'")
					local result = dbPoll(query, -1)
					if result and #result == 1 then
						if DBsatz == "skin" then
							if tonumber(wert) and tonumber(wert) >= 0 then
								if (getPlayerFromName(target) == false) then
									dbExec(handler, "UPDATE users SET skin= '"..wert.."' WHERE spieler = '"..target.."'")
									outputChatBox("Du hast "..target.." den die Skinid "..wert.." gesetzt!", player, 0, 255, 0)
								else
									outputChatBox("Der Spieler ist online!", player, 255, 0, 0)
								end
							else
								outputChatBox("Verwende /aset Name Zeile Wert", player, 255, 0, 0)
							end
						elseif DBsatz == "admin" then
							if  tonumber(wert) and tonumber(wert) <= 2 then
								dbExec(handler, "UPDATE users SET admin= '"..wert.."' WHERE spieler = '"..target.."'")
								outputChatBox("Du hast "..target.." den Adminrang "..wert.." gesetzt!", player, 0, 255, 0)
								if not (getAdmin(getPlayerFromName(target)) == nil) then
									if tonumber(wert) == 0 then 
										outputChatBox("[Admin] Du wurdest von "..getPlayerName(player).." aus dem Adminteam geworfen!", getPlayerFromName(target), 255, 0, 0)
										AdminTable[getPlayerFromName(target)] = nil
									elseif getAdmin(getPlayerFromName(target)) > tonumber(wert) then
										outputChatBox("[Admin] Du wurdest von "..getPlayerName(player).." degradiert!", getPlayerFromName(target), 255, 0, 0)
										AdminTable[getPlayerFromName(target)] = tonumber(wert)
									elseif getAdmin(getPlayerFromName(target)) < tonumber(wert) then
										outputChatBox("[Admin] Du wurdest von "..getPlayerName(player).." befördert!", getPlayerFromName(target), 0, 255, 0)
										AdminTable[getPlayerFromName(target)] = tonumber(wert)
									end
								else
									outputChatBox("testerr1", player)
								end
							else
								outputChatBox("Maximal Level 2!", player, 255, 0, 0)
							end
						else
							outputChatBox("Verwende /aset Name Zeile Wert", player, 255, 0, 0)
						end
					else
						dbFree(query)
						outputChatBox("Der Spieler ist nicht vorhanden!", player, 255, 0, 0)
					end				
				else
					outputChatBox("Verwende /aset Name Zeile Wert", player, 255, 0, 0)
				end
			else
				outputChatBox("Verwende /aset Name Zeile Wert", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /aset Name Zeile Wert", player, 255, 0, 0)		
		end
	end
end)


addCommandHandler("support",
function(player)
	if getAdmin(player) >= 1 then
		if getElementAlpha(player) == 255 then
			setElementAlpha(player, 150)
			triggerClientEvent("SupportAlpha", player)
			outputChatBox("Support aktiviert!", player, 0, 255, 0)
		elseif not (getElementAlpha(player) == 255) then
			setElementAlpha(player, 255)
			triggerClientEvent("SupportAlpha", player)
			outputChatBox("Support deaktiviert!", player, 255, 0, 0)
		end
	end
end)

local function unspy(player)
	if not (Spec[player] == nil)then
		detachElements(player, Spec[player][4])
		setElementPosition(player, Spec[player][1], Spec[player][2], Spec[player][3])
		setElementAlpha(player, 255)
		setElementCollisionsEnabled(player, true)
		Spec[player] = nil
		triggerClientEvent(player,"SpecVehicleEnter", player, spieler)
		setCameraTarget(player, player)
		toggleAllControls(player, true)
		triggerClientEvent(player,"SpectMode", player)
		outputChatBox("Du hast den Spy-Modus verlassen.", player, 255, 0, 0)
		setElementData(player, "Spy", 0)
		unbindKey(player, "SPACE", "down", unspy)
	end
end

addCommandHandler("aspy",
function(player, cmd, target)
	if getAdmin(player) >= 1 then
		if not (target == nil) then
			if not (string.lower(getPlayerName(player)) == string.lower(target)) then
				if not (getPlayerFromName(target) == false) then
					if Spec[player] == nil then
						local spieler = getPlayerFromName(target)
						local sx, sy, sz = getElementPosition(spieler)
						local x, y, z = getElementPosition(player)
						Spec[player] = {
							[1] = x,
							[2] = y,
							[3] = z,
							[4] = spieler
						}
						setElementAlpha(player, 0)
						setElementData(player, "Spy", 1)
						setElementCollisionsEnabled(player, false)
						setElementPosition(player, sx, sy, sz)
						triggerClientEvent(player,"SpecVehicleEnter", player, spieler)
						triggerClientEvent(player,"SpectMode", player)
						
						attachElements(player, spieler, 0, 0, -2.5)
						toggleAllControls(player, false)
						outputChatBox("Du beobachtest nun Spieler "..target.." Drücke die Leertaste um den Spymodus zu verlassen.", player, 0, 255, 0)
						setCameraTarget(player, spieler)
						bindKey(player, "SPACE", "up", unspy)
					end
				else
					outputChatBox("Verwende bitte /aspy Name", player, 255, 0, 0)
				end
			else
				outputChatBox("Du kannst dich nicht selber Beobachten!", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende bitte /aspy Name", player, 255, 0, 0)
		end
	end
end)

local function up(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		local x, y, z = getElementPosition(getPedOccupiedVehicle(player))
		setElementPosition(veh, x, y, (z)+2)
	else
		local x, y, z = getElementPosition(player)
		setElementPosition(player, x, y, (z)+2)
	end
end
local function down(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		local x, y, z = getElementPosition(getPedOccupiedVehicle(player))
		setElementPosition(veh, x, y, (z)-2)
	else
		local x, y, z = getElementPosition(player)
		setElementPosition(player, x, y, (z)-2)
	end
end
local function left(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		local x, y, z = getElementPosition(getPedOccupiedVehicle(player))
		setElementPosition(veh, (x)-2, y, z)
	else
		local x, y, z = getElementPosition(player)
		setElementPosition(player, (x)-2, y, z)
	end
end
local function right(player)
	if getPedOccupiedVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		local x, y, z = getElementPosition(getPedOccupiedVehicle(player))
		setElementPosition(veh, (x)+2, y, z)
	else
		local x, y, z = getElementPosition(player)
		setElementPosition(player, (x)+2, y, z)
	end
end

addCommandHandler("air",
function(player)
	if getAdmin(player) >= 1 then
		if air[player] == nil then
			setElementRotation(player, 0, 0, 0)
			bindKey(player, "arrow_u", "down", up)
			bindKey(player, "arrow_d", "down", down)
			bindKey(player, "arrow_l", "down", left)
			bindKey(player, "arrow_r", "down", right)
			outputChatBox("Air-Modus aktiviert!", player, 0, 255, 0)
			air[player] = true
		else
			unbindKey(player, "arrow_u", "down", up)
			unbindKey(player, "arrow_d", "down", down)
			unbindKey(player, "arrow_l", "down", left)
			unbindKey(player, "arrow_r", "down", right)
			outputChatBox("Air-Modus deaktiviert!", player, 255, 0, 0)
			air[player] = nil
		end
	end
end)

addCommandHandler("flip",
function(player)
	if getAdmin(player) >= 4 then
		if getPedOccupiedVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			x, y, z = getElementRotation(veh)
			setElementRotation(veh, 0, y, z)
		end
	end
end)

addCommandHandler("amessage",
function(player, cmd, target, ...)
	local message = table.concat({...}, " ")
	if getAdmin(player) >= 1 then
		if not (target == nil) then
			if not (... == nil) then
				if getPlayerFromName(target) then
					local spieler getPlayerFromName(target)
					outputChatBox("[Admin] Nachricht von "..getPlayerName(player)..": "..message, spieler, 0, 255, 255)
					outputChatBox("Du hast "..target.." eine Nachricht versendet", player, 0, 255, 0)
				else
					local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = '"..target.."'")
					local result = dbPoll(query, -1)
					if result and #result == 1 then
						dbExec(handler, "INSERT INTO omessage (spieler, admin, message) VALUES (?, ?, ?)", target, getPlayerName(player), message)
						outputChatBox("Du hast "..target.." eine Offline-Nachricht versendet", player, 0, 255, 0)
					else
						dbFree(query)
						outputChatBox("Der Account ist nicht vorhanden", player, 255, 0, 0)
					end
				end
			else
				outputChatBox("Verwende /amessage Name Nachricht", player, 255, 0, 0)
			end
		else
			outputChatBox("Verwende /amessage Name Nachricht", player, 255, 0, 0)
		end
	end	
end)

local vtester = createVehicle(583, 641, -573, 17, 0, 0, 0)

removeVehicleSirens(vtester)
addVehicleSirens(vtester, 2, 2, true, false, true, true)
setVehicleSirens(vtester, 1, 0.4, -0.3, 1.6, 255, 35.7, 0, 255, 255)
setVehicleSirens(vtester, 2, 0, 0, 0, 0, 0, 0, 200, 200)

--setVehicleColor(vtester, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)


addEventHandler("onElementDataChange", getRootElement(),
function(dataString, old)
	if dataString == "Spy" then
		if source == client then
			setElementData(source, "Spy", old)
		end
	end
end)