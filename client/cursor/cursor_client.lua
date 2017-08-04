local b = 0

local function bPress()
	if b == 0 then
		showCursor(true)
		b = 1
	elseif b == 1 then
		showCursor(false)
		b = 0
	end
end

addEventHandler("onClientResourceStart", root,
function()
	bindKey("b", "down", bPress)
end)


addCommandHandler("brefresh",
function()
	unbindKey("b", "down", bPress)
	b = 0
	bindKey("b", "down", bPress)
	outputChatBox("Der Bind wurde neu gebindet!", 0, 255, 0)
end)