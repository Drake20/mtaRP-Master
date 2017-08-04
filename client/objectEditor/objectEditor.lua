local object;
local setPositionFromObject;
local bindPause;
local bindDownState;
local rotateTheObjectDown;
local rotateTheObjectUp;
local pause = false
local objectTbl = {}
local masse;

function startObjectEditor(id)
	local x, y, z = getElementPosition(getLocalPlayer())
	--px, py, pz, lx, ly, lz = getCameraMatrix(getLocalPlayer())
	object = createObject(id, x+5, y, z)
	setElementAlpha(getLocalPlayer(), 0)
	--setCameraMatrix(px, py, pz, lx, ly, lz)
	setElementCollisionsEnabled(object, false)
	masse = getElementDistanceFromCentreOfMassToBaseOfModel(object);
	setElementFrozen(getLocalPlayer(), true)
	showCursor(true)
	outputChatBox("Sobald du die Ansicht wechseln willst drücke einfach Rechtsklick und posizioniere dich neu!\nMit dem Scrollrad kannst du das Object drehen!", 0, 255, 0)
	addEventHandler("onClientRender", getRootElement(), setPositionFromObject)
	bindKey("mouse2", "down", bindPause)
	bindKey("mouse1", "down", bindDownState)
	bindKey("mouse_wheel_down", "down", rotateTheObjectDown)
	bindKey("mouse_wheel_up", "down", rotateTheObjectUp)
end


function bindPause()
	if isCursorShowing(getLocalPlayer()) then
		pause = true
		showCursor(false)
		outputChatBox("Du hast die Objectplazierung gestoppt du kannst fortfahren indem du einmal rechts Klickst!", 0, 255, 0)
		setElementAlpha(getLocalPlayer(), 255)
		setElementFrozen(getLocalPlayer(), false)
	else
		showCursor(true)
		setElementAlpha(getLocalPlayer(), 0)
		--setCameraMatrix(px, py, pz, lx, ly, lz)
		setElementFrozen(getLocalPlayer(), true)
		pause = false
	end
end


function bindDownState()
	removeEventHandler("onClientRender", getRootElement(), setPositionFromObject)
	outputChatBox("Objekt plaziert!", 0, 255, 0)
	unbindKey("mouse2", "down", bindPause)
	unbindKey("mouse1", "down", bindDownState)
	unbindKey("mouse_wheel_down", "down", rotateTheObjectDown)
	unbindKey("mouse_wheel_up", "down", rotateTheObjectUp)
	setElementFrozen(getLocalPlayer(), false)
	setElementAlpha(getLocalPlayer(), 255)
	setElementCollisionsEnabled(object, true)
	local x, y, z = getElementPosition(object)
	local rx, ry, rz = getElementRotation(object)
	triggerServerEvent("plantObjectForServer", getLocalPlayer(), getElementModel(object), x, y, z, rx, ry, rz)
	destroyElement(object)
	showCursor(false)
	pause = false
end

function rotateTheObjectUp()
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z+1)
end

function rotateTheObjectDown()
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z-1)
end



function setPositionFromObject()
    if pause == false then
		local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
		local px, py, pz = getCameraMatrix()
		masse = getElementDistanceFromCentreOfMassToBaseOfModel(object);
		local hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, worldx, worldy, worldz, true, true, false)

		if hit then
			setElementPosition(object, x, y, z+masse-0.05)
		end
	end
end