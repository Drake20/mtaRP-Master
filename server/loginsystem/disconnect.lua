addEventHandler("onPlayerQuit", getRootElement(),
function()
	if getAdmin(player) >= 1 then
		AdminTable[source] == nil
	end
end)