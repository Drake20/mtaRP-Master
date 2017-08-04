local screenW, screenH = guiGetScreenSize()
local Repair;
local theReapair;
local var = 0

addEvent("startSchoolWeb", true)
addEventHandler("startSchoolWeb", getLocalPlayer(),
function()
	if var == 0 then
		var = 1
		School = guiCreateBrowser((screenW-300)/2, (screenH-550)/2, 300, 550, true, false, false)
		theSchool = guiGetBrowser(School)
		function createSchoolBr()
			loadBrowserURL(source, "http://mta/general/client/vehiclesystem/DrivingSchool_Choose.html")
		end
		addEventHandler("onClientBrowserCreated", theSchool, createSchoolBr)
		showCursor(true)
	end
end)

addEvent("School_ClassA", true)
addEventHandler("School_ClassA", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 1)
end)

addEvent("School_ClassB", true)
addEventHandler("School_ClassB", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 2)
end)

addEvent("School_ClassC", true)
addEventHandler("School_ClassC", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 3)
end)
addEvent("School_ClassD", true)
addEventHandler("School_ClassD", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 4)
end)

addEvent("School_ClassT", true)
addEventHandler("School_ClassT", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 5)
end)

addEvent("School_ClassHeli", true)
addEventHandler("School_ClassHeli", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 6)
end)

addEvent("School_ClassF1", true)
addEventHandler("School_ClassF1", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 7)
end)

addEvent("School_ClassF2", true)
addEventHandler("School_ClassF2", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 8)
end)

addEvent("School_ClassBoat", true)
addEventHandler("School_ClassBoat", getRootElement(),
function()
	triggerServerEvent("checkLicence", getLocalPlayer(), 9)
end)

addEvent("schoolLoadInformation", true)
addEventHandler("schoolLoadInformation", getRootElement(),
function()
	loadBrowserURL(theSchool, "http://mta/general/client/vehiclesystem/infor.html")
	guiSetSize (School, 700, 900, false)
	guiSetPosition(School, (screenW-700)/2, (screenH-900)/2, false)
end)


addEvent("SchoolBackToMain", true)
addEventHandler("SchoolBackToMain", getRootElement(),
function()
	loadBrowserURL(theSchool, "http://mta/general/client/vehiclesystem/DrivingSchool_Choose.html")
	guiSetSize (School,300, 550, false)
	guiSetPosition(School, (screenW-300)/2, (screenH-550)/2, false)
end)


addEvent("closeSchoolWebWindow", true)
addEventHandler("closeSchoolWebWindow", getRootElement(),
function()
	removeEventHandler("onClientBrowserCreated", theSchool, createSchoolBr)
	guiSetVisible(School, false)
	showCursor(false)
	var = 0
end)

addEvent("setDimensionPlayer", true)
addEventHandler("setDimensionPlayer", getLocalPlayer(),
function(var)
	if var == 2 then
		setElementDimension(getLocalPlayer(), 3)
	elseif var == 1 then
		setElementDimension(getLocalPlayer(), 0)
	end
end)