local screenW, screenH = guiGetScreenSize()
local AufX =  1920
local AufY =  1080
local Ax = screenW/AufX/32
local Ay = screenH/AufY/32

local Ber1 = screenW/1920
local Ber2 = screenH/1080

local degree = 0
local roll = 0
local iconAnim = false

local function startIconSmile()
    degree = degree+5
	if iconAnim == true then
		roll = roll+6
	end
	dxDrawImage(((screenW - 147) / 2)+roll, (screenH - 136) / 2, 147, 136, "res/images/favicon.png", degree, 0, 0, tocolor(255, 255, 255, 255), false)
end

local function startText_1 ()
	if iconAnim == true then
		roll = roll+6
	end
	dxDrawText("Herzlich Willkommen", ((screenW - 359) / 2)+roll, (screenH - 94) / 2, ((screenW - 359) / 2) + 359, ( (screenH - 94) / 2) + 94, tocolor(255, 255, 255, 255), 3.00, "default", "left", "top", false, false, false, false, false)
end

local function startText_2()
    if iconAnim == true then
		roll = roll+6
	end
	dxDrawText("In dieser Einleitung werden dir ein paar Sachen gezeigt..", ((screenW - 945) / 2)+roll, (screenH - 58) / 2, ((screenW - 945) / 2) + 945, ( (screenH - 58) / 2) + 58, tocolor(255, 255, 255, 255), 3.00, "default", "left", "top", false, false, false, false, false)
end



local function startText_3()
    if iconAnim == true then
		roll = roll+6
	end    
	dxDrawText("Fangen wir an ..", ((screenW - 276) / 2)+roll, (screenH - 54) / 2, ((screenW - 276) / 2) + 276, ( (screenH - 54) / 2) + 54, tocolor(255, 255, 255, 255), 3.00, "default", "left", "top", false, false, false, false, false)
end



local function startText_4()
    dxDrawRectangle(586*Ax, 0*Ay, 816*Ax, 66*Ay, tocolor(1, 1, 0, 170), false)
    dxDrawText("Kaufe ein Ticket in dem du auf den makierten Automaten mit B drückst!", 697*Ax, 20*Ay, 1302*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end



local function startText_5()
    dxDrawRectangle(586*Ax, 0*Ay, 816*Ax, 66*Ay, tocolor(1, 1, 0, 170), false)
    dxDrawText("Steige in den Zug!", 898, 20, 1054, 47, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end



-- Im Zug Texte --


local function startText_6()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
   dxDrawText("Ah, du hast es geschafft. Lehne dich zurück betrachte die Landschaft und lese die Tipps!", 635*Ax, 18*Ay, 1366*Ax, 50*Ay, tocolor(254, 254, 254, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_7()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
	dxDrawText("Mit U öffnest du dein Inventar", 854*Ax, 20*Ay, 1106*Ax, 49*Ay, tocolor(254, 254, 254, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_8()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)   
   dxDrawText("Auf der Map sind viele Objekte, die du durch das Anklicken sammeln kannst.", 691*Ax, 20*Ay, 1331*Ax, 48*Ay, tocolor(254, 254, 254, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_9()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("In ganz San Andreas gibt es viele Shops in denen du z.B Grillfleisch zum Grillen bekommst.", 614*Ax, 21*Ay, 1378*Ax, 48*Ay, tocolor(254, 254, 254, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_10()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("Viele Läden sind auf die Hilfe anderer angewiesen, denn Sie müssen beliefert werden.", 633*Ax, 21*Ay, 1397*Ax, 48*Ay, tocolor(254, 254, 254, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_11()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("In ganz San Andreas gibt es ein umfangreiches Wirtschaftssystem.", 728*Ax, 21*Ay, 1288*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_12()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("Weitere Infos dazu findest du unter /help", 819*Ax, 21*Ay, 1172*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_13()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("Neben dem Hauptbahnhof in Los Santos gibt es einen Fahrzeugverleih.", 702*Ax, 21*Ay, 1292*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

local function startText_14()
    dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("Solltest du Fragen haben oder hast einen Vorschlag für den Server dann verwende /report", 614*Ax, 21*Ay, 1372*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end

-- Außerhalb des Zugs


local function startText_15()
	dxDrawRectangle(586*Ax, 0*Ay, 815*Ax, 65*Ay, tocolor(5, 0, 0, 140), false)
    dxDrawText("Gehe zu der Frau und klicke mit B auf sie.", 799*Ax, 21*Ay, 1178*Ax, 48*Ay, tocolor(255, 255, 255, 255), 1.50, "default", "left", "top", false, false, false, false, false)
end


local Isound;

addEvent("startClientIntro", true)
addEventHandler("startClientIntro", getLocalPlayer(),
function()
	Isound = playSound("http://gamerzcom.de/IntroSound.mp3")
	showChat(false)
	showCursor(false)
	showPlayerHudComponent("all", false)
	setTimer(
	function()
		addEventHandler("onClientRender", getRootElement(), startIconSmile) 
		setTimer(
		function()
			setTimer(
			function()
				removeEventHandler("onClientRender", getRootElement(), startIconSmile) 
				addEventHandler("onClientRender", getRootElement(), startText_1) 
				roll = 0
				iconAnim = false
				setTimer(
				function()
					iconAnim = true
					setTimer(
					function()
						iconAnim = false
						roll = 0
						removeEventHandler("onClientRender", getRootElement(), startText_1) 
						addEventHandler("onClientRender", getRootElement(), startText_2) 
						setTimer(
						function()
							iconAnim = true
							setTimer(
							function()
								iconAnim = false
								roll = 0
								removeEventHandler("onClientRender", getRootElement(), startText_2) 
								addEventHandler("onClientRender", getRootElement(), startText_3) 
								setTimer(
								function()
									iconAnim = true
									setTimer(
									function()
										iconAnim = false
										roll = 0
										removeEventHandler("onClientRender", getRootElement(), startText_3) 
										fadeCamera(true, 2)
												triggerServerEvent("spawnPlayerOverIntro", getLocalPlayer())
												showChat(true)
												showCursor(false)
												showPlayerHudComponent("all", true)
												outputChatBox("Kaufe ein Ticket in dem du auf den makierten Automaten mit B drückst!", 0, 255, 0)
									end, 6000, 1)
								end, 4000, 1)
							end, 7000, 1)
						end, 4000, 1)
					end, 7000, 1)
				end, 3000, 1)
			end, 5000, 1)
			iconAnim = true
		end, 4000, 1)
	end, 2000, 1)
end)

local cMarker;
local cAutom;
local lplayer;

addEvent("createIntroMarker", true)
addEventHandler("createIntroMarker", getLocalPlayer(),
function(dim)
	cMarker = createMarker(2856, 1279.0999755859, 13.10000038147, "arrow", 1, 0, 131, 3)
	setElementDimension(cMarker, dim)
	setTimer(
	function()
		stopSound(Isound)
	end, 3000, 1)
end)

local BahnMeldung;

addEvent("startTrainIntro", true)
addEventHandler("startTrainIntro", getLocalPlayer(),
function()
	if BahnMeldung == 0 then
		BahnMeldung = 1
		outputChatBox("Steige in den Zug!", 0, 255, 0)
	end
end)
addEvent("startSpeedTimers", true)
addEventHandler("startSpeedTimers", getLocalPlayer(),
function(train)
			setTimer(
				function()
					setTrainSpeed(train, 1)
				setTimer(
				function()
					setTrainSpeed(train, 1)
					setTimer(
					function()
						setTrainSpeed(train, 1)
						setTimer(
						function()
							setTrainSpeed(train, 1)
							outputChatBox(getPlayerName(getLocalPlayer()))
							setTimer(
							function()
								setTrainSpeed(train, 1)
								setTimer(
								function()
									setTrainSpeed(train, 1)
									setTimer(
									function()
										setTrainSpeed(train, 1)
										setTimer(
										function()
											setTrainSpeed(train, 1)
											setTimer(
											function()
												setTrainSpeed(train, 1)
												setTimer(
												function()
													setTrainSpeed(train, 1)
													setTimer(
													function()
														setTrainSpeed(train, 0.8)
														setTimer(
														function()
															setTrainSpeed(train, 0.7)
															setTimer(
															function()
																setTrainSpeed(train, 0.6)
																setTimer(
																function()
																	setTrainSpeed(train, 0.5)
																	setTimer(
																	function()
																		setTrainSpeed(train, 0.4)
																		setTimer(
																		function()
																			setTrainSpeed(train, 0.3)
																			setTimer(
																			function()
																				setTrainSpeed(train, 0.2)
																				setTimer(
																				function()
																					outputChatBox("ende")
																					setTrainSpeed(train, 0.1)
																				end, 6000, 1)
																			end, 9000, 1)
																		end, 9000, 1)
																	end, 5000, 1)
																end, 5000, 1)
															end, 6000, 1)
														end, 8000, 1)
													end, 15000, 1)
												end, 6000, 1)
											end, 6000, 1)
										end, 6000, 1)
									end, 6000, 1)
								end, 6000, 1)
							end, 6000, 1)
						end, 6000, 1)
					end, 6000, 1)
				end, 6000, 1)
			end, 3000, 1)
end)


addEvent("startExitTrain", true)
addEventHandler("startExitTrain", getLocalPlayer(),
function()
outputChatBox("test")
	setControlState("enter_exit", true)
end)


addEvent("finishedIntro", true)
addEventHandler("finishedIntro", getRootElement(),
function()
	triggerServerEvent("deleteObjects", getLocalPlayer())
	removeEventHandler("onClientGUIClick", root, InjectIntroBR)
	removeEventHandler("onClientBrowserCreated", theBrowserIntro, onIntroBRCreated) 
	guiSetVisible(browserIntro, false)
	showCursor(false)
end)

local brow2 = 0
local browserIntroTicket;
local theBrowserIntroTicket;

addEvent("startTicketScreen", true)
addEventHandler("startTicketScreen", getLocalPlayer(),
function()	
	if brow2 == 0 then
		brow2 = 1
		browserIntroTicket = guiCreateBrowser((screenW-400)/2, (screenH-570)/2, 400, 570, true, false, false)
		theBrowserIntroTicket = guiGetBrowser(browserIntroTicket)
		function onIntroTicketBRCreated()	
			loadBrowserURL(theBrowserIntroTicket, "http://mta/general/client/intro/ticketIntro.html")
			showCursor(true)
		end
		addEventHandler("onClientBrowserCreated", theBrowserIntroTicket, onIntroTicketBRCreated) 
		function InjectIntroTicket(button, state)
			if state == "down" then
				injectBrowserMouseDown(theBrowserIntroTicket, button)
			else
				injectBrowserMouseUp(theBrowserIntroTicket, button)
			end
		end
		addEventHandler("onClientGUIClick", root, InjectIntroTicket)
	end
end)

local buy = 0

addEvent("stopTicketScreen", true)
addEventHandler("stopTicketScreen", getRootElement(),
function()
	if buy == 0 then
		buy = 1
		outputChatBox("Du hast dir erfolgreich ein Ticket zum Los Santos Hauptbahnhof gekauft", 0, 200, 0)
		showCursor(false)
		guiSetVisible(browserIntroTicket, false)
		removeEventHandler("onClientGUIClick", root, InjectIntroTicket)
		removeEventHandler("onClientBrowserCreated", theBrowserIntroTicket, onIntroTicketBRCreated)
		triggerServerEvent("setTableIntro", getLocalPlayer())
	end
end)

local message = 0

setDevelopmentMode(true, true)

local browserIntroMessage;
local theBrowserIntroMessage;

addEvent("startClientTipps", true)
addEventHandler("startClientTipps", getLocalPlayer(),
function()	
		if message == 0 then
			message = 1
			--removeEventHandler("onClientRender", getRootElement(), startText_5)
			browserIntroMessage = guiCreateBrowser((screenW-700)/2, 0, 700, 50, true, true, false)
			theBrowserIntroMessage = guiGetBrowser(browserIntroMessage)
			function onMessageIntro()	
				loadBrowserURL(theBrowserIntroMessage, "http://mta/general/client/intro/look.html")
			end
			executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Ah, du hast es geschafft. Lehne dich zurück betrachte die Landschaft und lese die Tipps!'"..")") 
			addEventHandler("onClientBrowserCreated", theBrowserIntroMessage, onMessageIntro) 
			--addEventHandler("onClientRender", getRootElement(), startText_6) 
			setTimer(
			function()
				executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Mit U öffnest du dein Inventar'"..")") 
				setTimer(
				function()
					executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Auf der Map sind viele Objekte, die du durch das Anklicken sammeln kannst'"..")") 
					setTimer(
					function()
						executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'In ganz San Andreas gibt es viele Shops in denen du z.B Grillfleisch zum Grillen bekommst'"..")") 
						setTimer(
						function()
							executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Viele Läden sind auf die Hilfe anderer angewiesen, denn Sie müssen beliefert werden'"..")") 
							setTimer(
							function()
								executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'In ganz San Andreas gibt es ein umfangreiches Wirtschaftssystem'"..")") 
								setTimer(
								function()
									executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Weitere Infos dazu findest du unter /help'"..")") 
									setTimer(
									function()
										executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Neben dem Hauptbahnhof in Los Santos gibt es einen Fahrzeugverleih'"..")") 
										setTimer(
										function()
											executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Solltest du Fragen haben oder hast einen Vorschlag für den Server dann verwende /report'"..")") 
											setTimer(
											function()
												guiSetVisible(browserIntroMessage, false)
											end, 8000, 1)
										end, 8000, 1)
									end, 8000, 1)
								end, 8000, 1)
							end, 9000, 1)
						end, 9000, 1)
					end, 9000, 1)
				end, 9000, 1)
			end, 9000, 1)
		end
end)

local brow1 = 0
local browserIntro;
local theBrowserIntro;

addEvent("startTutorialScreen", true)
addEventHandler("startTutorialScreen", getLocalPlayer(),
function()
	if brow1 == 0 then
		guiSetVisible(browserIntroMessage, false)
		removeEventHandler("onClientBrowserCreated", theBrowserIntroMessage, onMessageIntro) 
		brow1 = 1
		browserIntro = guiCreateBrowser((screenW-300)/2, (screenH-300)/2, 300, 300, true, false, false)
		theBrowserIntro = guiGetBrowser(browserIntro)
		function onIntroBRCreated()	
			loadBrowserURL(theBrowserIntro, "http://mta/general/client/intro/screen.html")
			showCursor(true)
		end
		addEventHandler("onClientBrowserCreated", theBrowserIntro, onIntroBRCreated) 
		function InjectIntroBR (button, state)
			if state == "down" then
				injectBrowserMouseDown(theBrowserIntro, button)
			else
				injectBrowserMouseUp(theBrowserIntro, button)
			end
		end
		addEventHandler("onClientGUIClick", root, InjectIntroBR)
	end
end)

addEvent("javatest", true)
addEventHandler("javatest", getRootElement(),
function()
	outputChatBox("Hat funktioniert!")
end)

addEvent("startLastrender", true)
addEventHandler("startLastrender", getLocalPlayer(),
function()
	guiSetVisible(browserIntroMessage, true)
	executeBrowserJavascript(theBrowserIntroMessage, "printMessage(".."'Beende das Tutorial in dem du mit B auf die Frau klickst'"..")") 
end)

addEvent("finishedIntro", true)
addEventHandler("finishedIntro", getRootElement(),
function()
	triggerServerEvent("deleteObjects", getLocalPlayer())
	removeEventHandler("onClientGUIClick", root, InjectIntroBR)
	removeEventHandler("onClientBrowserCreated", theBrowserIntro, onIntroBRCreated) 
	guiSetVisible(browserIntro, false)
	showCursor(false)
end)