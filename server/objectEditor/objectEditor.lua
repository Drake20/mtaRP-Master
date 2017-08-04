local objectInfo = {}
local startDeleteFromAdmin;

addEvent("plantObjectForServer", true)
addEventHandler("plantObjectForServer", getRootElement(),
function(id, x, y, z, rx, ry, rz)
	object = createObject(id, x, y, z, rx, ry, rz)
	objectInfo[object] = string.lower("|"..getPlayerName(source).."|"..id)
end)


addEventHandler("onElementClicked", getRootElement(),
function(button, state, player)
    if button == "left" and state == "down" then
		if getElementType(source) == "object" then
			if getAdmin(player) >= 1 then
				if objectInfo[source] == nil then return end
				outputChatBox("Besitzer: "..gettok(objectInfo[source], 1, string.byte("|")).."\nObjekt ID: "..gettok(objectInfo[source], 2, string.byte("|")), player, 0, 255, 0)
				outputChatBox("Um Objekte zu löschen musst du /odelete eintippen!", player, 255, 0, 0)
			end
		end
	end
end)

function startDeleteFromAdmin(button, state, player)
	if getAdmin(player) >= 1 then
		if button == "left" and state == "down" then
			if getElementType(source) == "object" then
				if objectInfo[source] == nil then return end
					if objectInfo[source] then
						destroyElement(source)
						outputChatBox("Du hast das Objekt von "..gettok(objectInfo[source], 1, string.byte("|")).." gelöscht!", player, 255, 0, 0)
						objectInfo[source] = nil
						removeEventHandler("onElementClicked", getRootElement(), startDeleteFromAdmin)
					end
			end
		end
	end
end

addCommandHandler("odelete", 
function(player)
	if getAdmin(player) >= 1 then
		outputChatBox("Klicke nun das Objekt an!", player, 0, 255, 0)
		addEventHandler("onElementClicked", getRootElement(), startDeleteFromAdmin)
	end
end)

