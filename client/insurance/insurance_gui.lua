
insuranceGui = {
    gridlist = {},
    window = {},
    button = {}
}

local cVehId;
local cVehName;
local guiSelected = 0

addEvent("openInsuranceGui", true)
addEventHandler("openInsuranceGui", getLocalPlayer(),
function()
    if guiSelected == 0 then
		guiSelected = 1
		triggerServerEvent("loadInsuranceList", getLocalPlayer())
		
		insuranceGui.window[1] = guiCreateWindow(764, 348, 311, 372, "", false)
        guiWindowSetSizable(insuranceGui.window[1], false)
        guiSetAlpha(insuranceGui.window[1], 0.87)

        insuranceGui.gridlist[1] = guiCreateGridList(9, 23, 294, 280, false, insuranceGui.window[1])
		cVehId = guiGridListAddColumn(insuranceGui.gridlist[1], "ID", 0.5)
        cVehName = guiGridListAddColumn(insuranceGui.gridlist[1], "Fahrzeug", 0.5)
        insuranceGui.button[1] = guiCreateButton(11, 309, 292, 27, "Einlösen", false, insuranceGui.window[1])
        guiSetProperty(insuranceGui.button[1], "NormalTextColour", "FFAAAAAA")
        insuranceGui.button[2] = guiCreateButton(11, 343, 291, 19, "Schließen", false, insuranceGui.window[1])
        guiSetProperty(insuranceGui.button[2], "NormalTextColour", "FFAAAAAA")

		-- Buttons --
		
		addEventHandler("onClientGUIClick", insuranceGui.button[1],
		function()
			if guiGridListGetSelectedItem(insuranceGui.gridlist[1]) == -1 then outputChatBox("Du hast kein Fahrzeug ausgewählt!", 255, 0, 0) return end
				local selectedOwnerId = guiGridListGetItemText (insuranceGui.gridlist[1], guiGridListGetSelectedItem(insuranceGui.gridlist[1]), cVehId)
				local selectedVehModel = guiGridListGetItemText (insuranceGui.gridlist[1], guiGridListGetSelectedItem(insuranceGui.gridlist[1]), cVehName)
				triggerServerEvent("enterInsuranceVehicle", getLocalPlayer(), selectedOwnerId, selectedVehModel)
				guiSetVisible(insuranceGui.window[1], false)
				guiSelected = 0
				showCursor(false)
		end, false)
		
		addEventHandler("onClientGUIClick", insuranceGui.button[2],
		function()
			guiSetVisible(insuranceGui.window[1], false)
			guiSelected = 0
			showCursor(false)
		end, false)
	end
end)

-- Gridliste --

addEvent("fillInsList", true)
addEventHandler("fillInsList", getLocalPlayer(),
function(ownerId, vehModel)
	local row = guiGridListAddRow(insuranceGui.gridlist[1])
	guiGridListSetItemText(insuranceGui.gridlist[1], row, cVehId, ownerId, false, false)
	guiGridListSetItemText(insuranceGui.gridlist[1], row, cVehName, vehModel, false, false)
end)
