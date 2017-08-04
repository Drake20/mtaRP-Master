local defaultTable = {[12] = "Staubsauger",
					  ["Beschreibung12"] = "Hallo123",
					  [13] = "Telefonbuch",
					   ["Beschreibung13"] = "Man kann nie genug haben",
					  }

local default = 0
local house = 0
local garden = 0
local hobby = 0
local job = 0
local dStrin, dInteger;
local hStrin, hInteger;
local gStrin, gInteger;
local hobbyStrin, hobbyInteger;
local jStrin, jInteger;
local idTick;

addEvent("fuellServersideInventar", true)
addEventHandler("fuellServersideInventar", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM inventar WHERE spieler = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		if result then
			if #result > 0 then
				for i, k in ipairs(result) do
					strin, dInteger = string.gsub(k["defaultObjects"], "|", "|")
					hStrin, hInteger = string.gsub(k["houseObjects"], "|", "|")
					gStrin, gInteger = string.gsub(k["gardenObjects"], "|", "|")
					hobbyStrin, hobbyInteger = string.gsub(k["hobbyObjects"], "|", "|")
					jStrin, jInteger = string.gsub(k["jobObjects"], "|", "|")
					if dInteger > 0 then
						for i=1, dInteger, 1 do
							local zahl = gettok(k["defaultObjects"], i, string.byte("|"))
							triggerClientEvent(source, "fillGridListFromInventar", source, tonumber(zahl), defaultTable[tonumber(zahl)], defaultTable["Beschreibung"..zahl]) --defaultTable[tonumber(zahl)]
						end
					end
					if hInteger > 0 then
						for i=house, hInteger, 1 do
							if not (house == hInteger) then
							end
						end
					end
					if gInteger > 0 then
						for i=garden, gInteger, 1 do
							if not (garden == gInteger) then
							end
						end
					end
					if hobbyInteger > 0 then
						for i=hobby, hobbyInteger, 1 do
							if not(hobby == hobbyInteger) then
							end
						end
					end
					if jInteger > 0 then
						for i=job, jInteger, 1 do
							if not(job == jInteger) then
								
							end
						end
					end
				end
			else
				triggerClientEvent(source, "fillGridListFromInventar", source, "-", "-", "-")
			end		
		else
			dbFree(query)
		end
	end
end)

addEvent("ServerQueryLicences", true)
addEventHandler("ServerQueryLicences", getRootElement(),
function()
	if source == client then
		local name
		local id
		local query = dbQuery(handler, "SELECT * FROM users WHERE spieler = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		if result then
		triggerClientEvent(source, "writeKategorieLicences", source, "ID", "Schein", "Erwerb")
			if #result > 0 then
				for i, k in ipairs(result) do
					local st, licences = string.gsub(k["licences"], "|", "|")
					if licences > 0 then
						for i=1, licences, 1 do
							if gettok(k["licences"], i, string.byte("|")) == "1" then
								if i == 1 then
									name = "Motorradschein (A1)"
									id = 1
								elseif i == 2 then
									name = "Autoschein (B)"
									id = 2
								elseif i == 3 then
									name = "Lastkraftwagenschein (C)"
									id = 3
								elseif i == 3 then
									name = "Lastkraftwagenschein (C)"
									id = 3
								elseif i == 4 then
									name = "Busschein (D)"
									id = 4
								elseif i == 5 then
									name = "Traktorschein (T)"
									id = 5
								elseif i == 6 then
									name = "Helikopterschein"
									id = 6
								elseif i == 7 then
									name = "Flugschein (F1)"
									id = 7
								elseif i == 8 then
									name = "Flugschein (F2)"
									id = 8
								elseif i == 9 then
									name = "Bootsschein"
									id = 9
								end
								local erwerb = gettok(k["licenceDate"], i, string.byte("|"))
								triggerClientEvent(source, "triggerToScriptLicences", source, id, name, erwerb)
							end
						end
					end
				end
			else
				triggerClientEvent(source, "triggerToScriptLicences", source, "-", "-", "-")
			end
		else
			dbFree(query)
		end
	end
end)

local ObjectTable = {
	[647] = "Gebüsch",
	[1372] = "große Mülltonne",
	[1481] = "Grill",
--	[3515] = "Brunnen",
	[3461] = "Fackel",
	[3504] = "Dixi Toilette",
	[3666] = "Lampenpoller",
	[1261] = "kleiner Unterstand",
	[2921] = "Überwachungskamera",
	[3430] = "kleine Mülltonne",
	[1371] = "Nilpferd Mülltonne",
	[1470] = "Holzveranda Ecke (links)",
	[1476] = "Holzveranda Ecke (rechts)",
	[1471] = "Holzveranda Mitte",
	[1472] = "Holzveranda Treppe",
	[1473] = "Holzveranda Dach 1",
	[1474] = "Holdveranda Dach 2",
	[650] = "Kaktus 1",
	[651] = "Kaktus 2",
	[653] = "Kaktus 3",
	[817] = "Blumen",
	[680] = "Baum 1",
	[673] = "Baum 2",
	[711] = "Palme",
	[2102] = "Musikanlage 1",
	[2103] = "Musikanlage 2",
	[2226] = "Musikanlage 3",
}

addEvent("ServerQueryObjects", true)
addEventHandler("ServerQueryObjects", getRootElement(),
function()
	if source == client then
		local id;
		local query = dbQuery(handler, "SELECT * FROM inventar WHERE spieler = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		if result then
				triggerClientEvent(source, "writeKategorieLicences", source, "ID", "Objekt", "-", true)
			if #result > 0 then
				for i, k in ipairs(result) do
					local st, objects = string.gsub(k["hobbyObjects"], "|", "|")
					if objects > 0 then
						for i=1, objects, 1 do
							id = gettok(k["hobbyObjects"], i, string.byte("|"))
							triggerClientEvent(source, "triggerToScriptLicences", source, id, ObjectTable[tonumber(id)], "-")
						end
						if objects == 0  or objects == false then
							triggerClientEvent(source, "triggerToScriptLicences", source, "-", "-", "-")
						end
					end
				end
			end
		else
			dbFree(query)
		end
	end
end)


addEvent("serverSendKeysToInventar", true)
addEventHandler("serverSendKeysToInventar", getRootElement(),
function()
	if source == client then
		local query = dbQuery(handler, "SELECT * FROM vehicles WHERE vehowner = ?;", getPlayerName(source))
		local result = dbPoll(query, -1)
		if result then
			triggerClientEvent(source, "writeKategorieLicences", source, "Auto", "Slot", "-")
			if #result > 0 then
				for k, v in ipairs(result) do
					local vehicle = v["vehid"]
					local id = v["ownerid"]
					triggerClientEvent(source, "triggerToScriptLicences", source, getVehicleNameFromModel(vehicle), id, "-")
				end
			else
				triggerClientEvent(source, "triggerToScriptLicences", source, "Du hast keine Fahrzeuge", " ", " ")
			end
		else
			dbFree(query)
			outputChatBox("Fehler #21, kontaktiere bitte umgehend einen Admin /report", source, 255, 0, 0)
		end
	end
end)
	