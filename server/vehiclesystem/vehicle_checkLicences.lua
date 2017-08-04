local CarIds = {[602] = true, [496] = true, [401] = true, [518] = true, [527] = true, [589] = true, 419, [587] = true, [533] = true, [526] = true, [474] = true, [545] = true, [517] = true, [410] = true, [600] = true, [436] = true, [439] = true, [549] = true, [491] = true, [445] = true, [604] = true, [507] = true, [585] = true, [466] = true, [492] = true, [546] = true, [551] = true, [516] = true, [467] = true, [426] = true, [547] = true, [405] = true, [580] = true, [409] = true, [550] = true, [566] = true, [540] = true, [421] = true, [529] = true, [485] = true, [438] = true, [574] = true, [420] = true, [525] = true, [552] = true, [490] = true, [528] = true, [470] = true, [596] = true, [598] = true, [599] = true, [597] = true, [428] = true, [499] = true, [609] = true, [498] = true, [423] = true, [414] = true, [459] = true, [422] = true, [482] = true, [605] = true, [530] = true, [418] = true, [572] = true, [582] = true, [413] = true, [440] = true, [543] = true, [583] = true, [478] = true, [554] = true, [579] = true, [400] = true, [404] = true, [489] = true, [505] = true, [479] = true, [442] = true, [458] = true, [536] = true, [575] = true, [534] = true, [567] = true, [535] = true, [576] = true, [412] = true, [402] = true, [542] = true, [603] = true, [475] = true, [429] = true, [541] = true, [415] = true, [480] = true, [562] = true, [565] = true, [434] = true, [494] = true, [502] = true, [503] = true, [411] = true, [559] = true, [561] = true, [560] = true, [506] = true, [451] = true, [558] = true, [555] = true, [477] = true, [568] = true, [424] = true, [504] = true, [457] = true, [483] = true, [508] = true, [571] = true, [500] = true, [556] = true, [557] = true, [444] = true, [471] = true, [495] = true, [539] = true}
local bikeIds = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}
local busIds = {[431] = true, [437] = true}
local tractorIds = { [532] = true,[531] = true}
local choppersIds = {[417] = true, [425] = true, [447] = true, [469] = true, [487] = true, [488] = true, [497] = true, [548] = true, [563] = true}
local flight1ds = {[460] = true, [476] = true, [511] = true, [512] = true, [513] = true, [553] = true, [593] = true}
local flight2Ids = {[519] = true,[520] = true, [577] = true, [592] = true}
local boatIds = {[430] = true, [452] = true, [453] = true, [454] = true, [472] = true, [473] = true, [484] = true, [493] = true, [595] = true}

addEventHandler("onVehicleStartEnter", getRootElement(),
function(player, seat)
	if seat == 0 then
		local model = getElementModel(source)
		if CarIds[model] and getPlayerElement(player, "carLicence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif bikeIds[model] and getPlayerElement(player, "bikeLicence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif busIds[model] and getPlayerElement(player, "busLicence") == 0 then
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif tractorIds[model] and getPlayerElement(player, "tractorLicence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif choppersIds[model] and getPlayerElement(player, "chopperLicence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif flight1ds[model] and getPlayerElement(player, "flight1Licence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif flight2Ids[model] and getPlayerElement(player, "flight2Licence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		elseif boatIds[model] and getPlayerElement(player, "boatLicence") == 0 then 
			cancelEvent()
			outputChatBox("Du hast keinen passenden Führerschein!", player, 255, 0, 0)
		end
	end
end)