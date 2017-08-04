function onThisResourceStart ( )
    downloadFile ("gui_client.lua")
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )