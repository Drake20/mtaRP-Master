addEventHandler("onPlayerChangeNick", getRootElement(),
function()
	outputChatBox("Du kannst deinen Namen nicht ändern! Melde dich bei einem Admin im Forum oder /report !", source, 255, 0, 0)
	cancelEvent()
end)