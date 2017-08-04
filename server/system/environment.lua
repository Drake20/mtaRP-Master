local Time = getRealTime()
local hour = Time.hour
local minute = Time.minute
local ResState = "loading"

setTime(hour, minute)
setMinuteDuration(60000)


addEventHandler("onResourceStart", resourceRoot,
function()
	ResState = "loading"
	setTimer(
	function()
			ResState = "ready"
			triggerClientEvent(getRootElement(),"startResourceWinLoad", getRootElement(), "ready")
	end, 30000, 1)
end)

addEvent("checkLoadingServer", true)
addEventHandler("checkLoadingServer", getRootElement(), 
function()
	if ResState == "loading" then
		triggerClientEvent(getRootElement(),"startResourceWinLoad", getRootElement(), "loading")
	elseif ResState == "ready" then
		triggerClientEvent(getRootElement(),"startResourceWinLoad", getRootElement(), "ready")
	end
end)
