addEvent("fillTableKategorieShop", true)
addEventHandler("fillTableKategorieShop", getRootElement(),
function(var1, var2, var3)
	local String1 = "'"..var1.."'"
	local String2 = "'"..var2.."'"
	local String3 = "'"..var3.."'"
	executeBrowserJavascript(windowTable[string.lower("thenpc_1Browser")], "writeKategorie("..String1..","..String2..","..String3..")")
end)

addEvent("fillTheColumnsFromShop", true)
addEventHandler("fillTheColumnsFromShop", getRootElement(),
function(var1, var2, var3)
	local String1 = "'"..var1.."'"
	local String2 = "'"..var2.."'"
	local String3 = "'"..var3.."'"	
	executeBrowserJavascript(windowTable[string.lower("thenpc_1Browser")], "fuellTheTable_Shop("..String1..","..String2..","..String3..")")
end)