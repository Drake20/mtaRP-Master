-- Fahrzeug vor dem Gebäude in Los Santos
local SchoolCar = createVehicle(589, 1678.8000488281, -1458.3000488281, 13.300000190735, 0, 0, 270, "LS 2017")
	setVehicleColor(SchoolCar, 0, 0, 0, 0, 0, 0)
	setElementFrozen(SchoolCar, true)
	setVehicleDamageProof(SchoolCar, true)
	setVehicleEngineState(SchoolCar, false)
	setVehicleLocked(SchoolCar, true)
-- Ende


local Enter_MarkerLS = createMarker(1685.4000244141, -1464.4000244141, 13.5, "corona", 1, 30, 254, 0)
--setElementPosition(player, 1685.1999511719, -1462.5, 13.5)


addEventHandler("onMarkerHit", Enter_MarkerLS,
function(hitElement)
	if getElementType(hitElement) == "player" then
		if not (isPedInVehicle(hitElement)) then
			triggerClientEvent(hitElement, "startSchoolWeb", hitElement)
		end
	end
end)

local function enterLicence(player)
	local query = dbQuery(handler, "SELECT licences FROM users WHERE spieler = '"..getPlayerName(player).."'")
	local result = dbPoll(query, -1)
	if result and #result > 0 then
		local lic = tonumber(gettok(result[1]["licences"], 2, string.byte('|')))
		lic = "|"..tonumber(gettok(result[1]["licences"], 1, string.byte('|'))).."|"..(1).."|"..tonumber(gettok(result[1]["licences"], 3, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 4, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 5, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 6, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 7, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 8, string.byte('|'))).."|"..tonumber(gettok(result[1]["licences"], 9, string.byte('|'))).."|"
		dbExec(handler, "UPDATE users SET licences = '"..lic.."' WHERE spieler ='"..getPlayerName(player).."'")
		setPlayerElement(player, "carLicence", 1)
	else
		dbFree(query)
		outputChatBox("Error ID: 2891. Wende dich per /report an einen Admin!", player, 255, 0, 0)
	end
end
local dimens = 1000

local saveSchoolData = {
	[1] = "",
	[2] = "",
	[3] = "",
};

local schoolvar1 = {
	[1] = {1688.9208984375, -1445.5703125, 11.133839607239},
	[2]	= {1846.091796875, -1478.0146484375, 11.037532806396},
	[3] = {1806.8095703125, -1830.103515625, 11.048782348633},
	[4] = {1692.375, -1792.349609375, 11.040886878967},
	[5] = {1663.5546875, -1729.7119140625, 11.040888786316},
	[6] = {1365.6259765625, -1729.6865234375, 11.040858268738},
	[7] = {1314.384765625, -1712.5869140625, 11.040905952454},
	[8] = {1375.0869140625, -1408.2568359375, 11.047877311707},
	[9] = {1487.9404296875, -1442.744140625, 11.040984153748},
	[10] = {1688.8173828125, -1445.5849609375, 11.12030506134},
}

local schoolvar2 = {
	[1] = {1688.8662109375, -1447.09375, 11.122176170349},
	[2] = {1608.744140625, -1415.263671875, 11.2611951828},
	[3] = {1565.1640625, -1297.482421875, 14.620439529419},
	[4] = {1457.146484375, -1269.2265625, 11.04087638855},
	[5] = {1360.21875, -1223.2607421875, 12.163043022156},
	[6] = {1379.2998046875, -963.4814453125, 31.569026947021},
	[7] = {1493.015625, -960.798828125, 33.79284286499},
	[8] = {2164.6015625, -1103.294921875, 23.034439086914},
	[9] = {2252.994140625, -1145.1640625, 24.050382614136},
	[10] = {2268.5693359375, -1199.9228515625, 22.059099197388},
	[11] = {2256.01171875, -1381.5029296875, 21.497129440308},
	[12] = {2109.9091796875, -1402.4072265625, 21.486232757568},
	[13] = {2091.53125, -1459.873046875, 21.434690475464},
	[14] = {1695.716796875, -1435.767578125, 11.120371818542},
}

local schoolvar3 = {
	[1] = {1688.5859375, -1446.4541015625, 11.122288703918},
	[2] = {1853.5703125, -1439.6630859375, 11.057635307312},
	[3] = {1827.4384765625, -1178.6552734375, 21.288888931274},
	[4] = {1371.033203125, -1138.8203125, 21.314376831055},
	[5] = {1384.513671875, -917.69921875, 32.015724182129},
	[6] = {1518.57421875, -815.4609375, 68.350784301758},
	[7] = {1266.44140625, -721.0048828125, 91.49104309082},
	[8] = {974.4140625, -806.630859375, 95.602516174316},
	[9] = {845.9912109375, -885.0361328125, 63.922920227051},
	[10] = {1023.3828125, -968.404296875, 39.933074951172},
	[11] = {1160.3662109375, -968.62109375, 39.479705810547},
	[12] = {1179.22265625, -1149.2490234375, 21.335264205933},
	[13] = {1452.4375, -1182.296875, 20.199419021606},
	[14] = {1478.3828125, -1443.0029296875, 11.040923118591},
	[15] = {1688.544921875, -1446.2314453125, 11.120296478271},
}

local schoolvar4 = {
	[1] = {1688.8115234375, -1447.05859375, 11.138016700745},
	[2] = {1655.4619140625, -1463.435546875, 11.043494224548},
	[3] = {1637.46484375, -1589.8564453125, 11.125122070312},
	[4] = {1427.212890625, -1607.45703125, 11.040954589844},
	[5] = {1408.2783203125, -1729.326171875, 11.048713684082},
	[6] = {1386.8447265625, -1767.5751953125, 11.040843963623},
	[7] = {1364.86328125, -1866.62109375, 11.040886878967},
	[8] = {1136.01171875, -1849.75390625, 11.040928840637},
	[9] = {1057.9541015625, -1828.26171875, 11.236390113831},
	[10] = {919.9384765625, -1745.3623046875, 11.038845062256},
	[11] = {935.0419921875, -1408.1064453125, 10.919409751892},
	[12] = {1360.2451171875, -1377.5126953125, 11.136984825134},
	[13] = {1377.19140625, -1242.984375, 11.040910720825},
	[14] = {1452.203125, -1265.6103515625, 11.04096031189},
	[15] = {1487.8232421875, -1304.5869140625, 11.313183784485},
	[16] = {1602.638671875, -1330.796875, 14.954177856445},
	[17] = {1626.1552734375, -1443.0126953125, 11.040914535522},
	[18] = {1688.5244140625, -1445.9853515625, 11.120272636414},
}

local tbName;

addEventHandler("onVehicleExit", getRootElement(),
function(player)
	if saveSchoolData[player] then
		destroyElement(saveSchoolData[player][5])
		destroyElement(saveSchoolData[player][7])
		destroyElement(saveSchoolData[player][1])
		destroyElement(saveSchoolData[player][4]) 
		saveSchoolData[player] = nil
		outputChatBox("Du hast die Prüfung abgebrochen!", player, 255, 0, 0)
		setElementDimension(player, 0)
		unbindKey(player, "m", "up", SchoolText1)
	end
end)

local function ChangeEnterMarker(hitElement)
	if getElementType(hitElement) == "vehicle" then
		local player = getVehicleOccupant(hitElement)
		if saveSchoolData[player] then
			if hitElement == saveSchoolData[player][5] then
				removeEventHandler("onMarkerHit", saveSchoolData[player][1], ChangeEnterMarker)
				destroyElement(saveSchoolData[player][1])
				destroyElement(saveSchoolData[player][4])
				saveSchoolData[player][2] = (saveSchoolData[player][2])+1
				if saveSchoolData[player][3] == 1 and saveSchoolData[player][2] == 11 then
					destroyElement(saveSchoolData[player][5])
					destroyElement(saveSchoolData[player][7])
					saveSchoolData[player] = nil
					outputChatBox("Du hast die Prüfung erfolgreich absolviert!", player, 0, 255, 0)
					setElementDimension(player, 0)
					enterLicence(player)
					return
				elseif saveSchoolData[player][3] == 2 and saveSchoolData[player][2] == 15 then
					destroyElement(saveSchoolData[player][5])
					destroyElement(saveSchoolData[player][7])
					saveSchoolData[player] = nil
					outputChatBox("Du hast die Prüfung erfolgreich absolviert!", player, 0, 255, 0)
					setElementDimension(player, 0)
					enterLicence(player)
					return
				elseif saveSchoolData[player][3] == 3 and saveSchoolData[player][2] == 16 then
					destroyElement(saveSchoolData[player][5])
					destroyElement(saveSchoolData[player][7])
					saveSchoolData[player] = nil
					outputChatBox("Du hast die Prüfung erfolgreich absolviert!", player, 0, 255, 0)
					setElementDimension(player, 0)
					enterLicence(player)
					return
				elseif saveSchoolData[player][3] == 4 and saveSchoolData[player][2] == 19 then
					destroyElement(saveSchoolData[player][5])
					destroyElement(saveSchoolData[player][7])
					saveSchoolData[player] = nil
					outputChatBox("Du hast die Prüfung erfolgreich absolviert!", player, 0, 255, 0)
					setElementDimension(player, 0)
					enterLicence(player)
					return
				else
					local MaName = string.lower("Marker"..saveSchoolData[player][2]..""..getPlayerName(player))
					local MaBlip = string.lower("Blip"..saveSchoolData[player][2]..""..getPlayerName(player))
					MaName = createMarker(tbName[saveSchoolData[player][2]][1], tbName[saveSchoolData[player][2]][2], tbName[saveSchoolData[player][2]][3], "checkpoint", 3, 30, 254, 0, 255, player)
					MaBlip = createBlip(tbName[saveSchoolData[player][2]][1], tbName[saveSchoolData[player][2]][2], tbName[saveSchoolData[player][2]][3], 0, 2, 30, 254, 0, 255, 0, 99999.0, player)
					setElementDimension(MaName, saveSchoolData[player][6])
					setElementDimension(MaBlip, saveSchoolData[player][6])
					saveSchoolData[player][1] = MaName
					saveSchoolData[player][4] = MaBlip
					addEventHandler("onMarkerHit", MaName, ChangeEnterMarker)
				end
			end
		end
	end
end

local function SchoolText1(player)
	outputChatBox("Machen wir weiter, mit O kannst du das Licht ein/ausschalten!", player, 255, 255, 0)
	unbindKey(player, "m", "up", SchoolText1)
	setTimer(
	function(player)
		outputChatBox("Mit der Leertaste kannst du bei den Privatcars deine Handbremse anziehen und lösen!", player, 255, 255, 0)
		setTimer(
		function(player)
			outputChatBox("Wenn du mit B auf dein eigenes Fahrzeug klickst, schließt du es auf!", player, 255, 255, 0)
			setTimer(
			function(player)
				outputChatBox("Mit K schaltest du das Radio an!", player, 255, 255, 0)
				setTimer(
				function(player)
					outputChatBox("Innerorst gilt Tempolimit 100 km/h", player, 255, 255, 0)
					setTimer(
					function(player)
						outputChatBox("Halte dich auch an alle Straßenordungen, sonst wird dich die Polizei anhalten!", player, 255, 255, 0)
					end, 5000, 1, player)
				end, 5000, 1, player)
			end, 5000, 1, player)
		end, 5000, 1, player)
	end, 5000, 1, player)
end

local function startVehicleClassA(player)
	if not (isPedInVehicle(player)) then
		local x, y, z = getElementPosition(player)
		if getDistanceBetweenPoints3D(x, y, z, 1685.4000244141, -1464.4000244141, 13.5) <= 15 then
			local variant = math.random(1, 4)
			local no = 1
				if variant == 1 then
					tbName = schoolvar1
				elseif variant == 2 then
					tbName = schoolvar2
				elseif variant == 3 then
					tbName = schoolvar3
				elseif variant == 4 then
					tbName = schoolvar4
				end
			dimens = dimens+1
			local MaName = string.lower("Marker"..no..""..getPlayerName(player))
			local MaBlip = string.lower("Blip"..no..""..getPlayerName(player))
			local Car = string.lower("Car"..getPlayerName(player))
			local Skin = string.lower("Teacher"..getPlayerName(player))
			Skin = createPed(72, 0, 0, 0)
			Car = createVehicle(589, 1678.8000488281, -1458.3000488281, 13.300000190735, 0, 0, 270, "LS 2017")
			warpPedIntoVehicle(player, Car, 0)
			warpPedIntoVehicle(Skin, Car, 1)
			MaBlip = createBlip(tbName[1][1], tbName[1][2], tbName[1][3], 0, 2, 30, 254, 0, 255, 0, 99999.0, player)
			MaName = createMarker(tbName[1][1], tbName[1][2], tbName[1][3], "checkpoint", 3, 30, 254, 0, 255, player)
			setElementDimension(Car, dimens)
			setElementDimension(MaBlip, dimens)
			setElementDimension(MaName, dimens)
			setElementDimension(Skin, dimens)
			setElementDimension(player, dimens)
			saveSchoolData[player] = {
				[1] = MaName,
				[2] = 1, --Markernummer
				[3] = variant, -- Variante
				[4] = MaBlip,
				[5] = Car,
				[6] = dimens,
				[7] = Skin,
			}
			outputChatBox("Du musst nun deine Prüfung absolvieren!", player, 0, 255, 0)
			outputChatBox("Schalte bitte mit M den Motor an!", player, 0, 255, 0)
			bindKey(player, "m", "up", SchoolText1, player)
			addEventHandler("onMarkerHit", saveSchoolData[player][1], ChangeEnterMarker)
		else
			outputChatBox("Du bist zu weit entfernt!", player, 255, 0, 0)
		end
	end
end

addCommandHandler("tp",
function(player)
	setElementPosition(player, 1688.9208984375, -1445.5703125, 13.5)
end)

addEvent("checkLicence", true)
addEventHandler("checkLicence", getRootElement(),
function(licence)
	if source == client then	
		if licence == 1 then -- A
			if getPlayerElement(source, "bikeLicence") == 0 then
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 2 then
			if getPlayerElement(source, "carLicence") == 0 then
				startVehicleClassA(source)
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 3 then
			if getPlayerElement(source, "lkwLicence") == 0 then
				--
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 4 then
			if getPlayerElement(source, "busLicence") == 0 then
			
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 5 then
			if getPlayerElement(source, "tractorLicence") == 0 then
				--
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 6 then
			if getPlayerElement(source, "chopperLicence") == 0 then
				--
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 7 then
			if getPlayerElement(source, "flight1Licence") == 0 then
				
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		elseif licence == 8 then
			if getPlayerElement(source, "flight2Licence") == 0 then
			
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end	
		elseif licence == 9 then
			if getPlayerElement(source, "boatLicence") == 0 then
			
			else
				outputChatBox("Du hast diese Klasse bereits!", source, 255, 0, 0)
			end
		end
	end
end)
--[[

--- Strecke 1

local var1_Marker1 = createMarker(1688.9208984375, -1445.5703125, 11.133839607239, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker2 = createMarker(1846.091796875, -1478.0146484375, 11.037532806396, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker3 = createMarker(1806.8095703125, -1830.103515625, 11.048782348633, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker4 = createMarker(1692.375, -1792.349609375, 11.040886878967, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker5 = createMarker(1663.5546875, -1729.7119140625, 11.040888786316, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker6 = createMarker(1365.6259765625, -1729.6865234375, 11.040858268738, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker7 = createMarker(1314.384765625, -1712.5869140625, 11.040905952454, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker8 = createMarker(1375.0869140625, -1408.2568359375, 11.047877311707, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker9 = createMarker(1487.9404296875, -1442.744140625, 11.040984153748, 'checkpoint', 3, 30, 254, 0, 255)
local var1_Marker10 = createMarker(1688.8173828125, -1445.5849609375, 11.12030506134, 'checkpoint', 3, 30, 254, 0, 255)



-- Strecke 2

local var2_Marker1 = createMarker(1688.8662109375, -1447.09375, 11.122176170349, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker2 = createMarker(1608.744140625, -1415.263671875, 11.2611951828, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker3 = createMarker(1565.1640625, -1297.482421875, 14.620439529419, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker4 = createMarker(1457.146484375, -1269.2265625, 11.04087638855, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker5 = createMarker(1360.21875, -1223.2607421875, 12.163043022156, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker6 = createMarker(1379.2998046875, -963.4814453125, 31.569026947021, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker7 = createMarker(1493.015625, -960.798828125, 33.79284286499, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker8 = createMarker(2164.6015625, -1103.294921875, 23.034439086914, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker9 = createMarker(2252.994140625, -1145.1640625, 24.050382614136, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker10 = createMarker(2268.5693359375, -1199.9228515625, 22.059099197388, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker11 = createMarker(2256.01171875, -1381.5029296875, 21.497129440308, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker12 = createMarker(2109.9091796875, -1402.4072265625, 21.486232757568, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker13 = createMarker(2091.53125, -1459.873046875, 21.434690475464, 'checkpoint', 3, 30, 254, 0, 255)
local var2_Marker14 = createMarker(1695.716796875, -1435.767578125, 11.120371818542, 'checkpoint', 3, 30, 254, 0, 255)

-- Strecke 3

local var3_Marker1 = createMarker(1688.5859375, -1446.4541015625, 11.122288703918, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker2 = createMarker(1853.5703125, -1439.6630859375, 11.057635307312, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker3 = createMarker(1827.4384765625, -1178.6552734375, 21.288888931274, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker4 = createMarker(1371.033203125, -1138.8203125, 21.314376831055, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker5 = createMarker(1384.513671875, -917.69921875, 32.015724182129, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker6 = createMarker(1518.57421875, -815.4609375, 68.350784301758, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker7 = createMarker(1266.44140625, -721.0048828125, 91.49104309082, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker8 = createMarker(974.4140625, -806.630859375, 95.602516174316, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker9 = createMarker(845.9912109375, -885.0361328125, 63.922920227051, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker10 = createMarker(1023.3828125, -968.404296875, 39.933074951172, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker11 = createMarker(1160.3662109375, -968.62109375, 39.479705810547, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker12 = createMarker(1179.22265625, -1149.2490234375, 21.335264205933, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker13 = createMarker(1452.4375, -1182.296875, 20.199419021606, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker14 = createMarker(1478.3828125, -1443.0029296875, 11.040923118591, 'checkpoint', 3, 30, 254, 0, 255)
local var3_Marker15 = createMarker(1688.544921875, -1446.2314453125, 11.120296478271, 'checkpoint', 3, 30, 254, 0, 255)


-- Strecke 4

local var4_Marker1 = createMarker(1688.8115234375, -1447.05859375, 11.138016700745, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker2 = createMarker(1655.4619140625, -1463.435546875, 11.043494224548, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker3 = createMarker(1637.46484375, -1589.8564453125, 11.125122070312, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker4 = createMarker(1427.212890625, -1607.45703125, 11.040954589844, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker5 = createMarker(1408.2783203125, -1729.326171875, 11.048713684082, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker6 = createMarker(1386.8447265625, -1767.5751953125, 11.040843963623, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker7 = createMarker(1364.86328125, -1866.62109375, 11.040886878967, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker8 = createMarker(1136.01171875, -1849.75390625, 11.040928840637, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker9 = createMarker(1057.9541015625, -1828.26171875, 11.236390113831, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker10 = createMarker(919.9384765625, -1745.3623046875, 11.038845062256, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker11 = createMarker(935.0419921875, -1408.1064453125, 10.919409751892, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker12 = createMarker(1360.2451171875, -1377.5126953125, 11.136984825134, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker13 = createMarker(1377.19140625, -1242.984375, 11.040910720825, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker14 = createMarker(1452.203125, -1265.6103515625, 11.04096031189, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker15 = createMarker(1487.8232421875, -1304.5869140625, 11.313183784485, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker16 = createMarker(1602.638671875, -1330.796875, 14.954177856445, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker17 = createMarker(1626.1552734375, -1443.0126953125, 11.040914535522, 'checkpoint', 3, 30, 254, 0, 255)
local var4_Marker18 = createMarker(1688.5244140625, -1445.9853515625, 11.120272636414, 'checkpoint', 3, 30, 254, 0, 255)


--]]