--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

addEventHandler("onResourceStart",root,function()
	setGameType("TerrorTown v0.1r1")
	setFPSLimit(CONFIG.FPS_LIMIT)
end)

addEventHandler("onPlayerJoin",root,function()
	setPlayerHudComponentVisible(source,"all",false)
	setPlayerHudComponentVisible(source,"crosshair",true)
	setElementData(source,"showhud",false)
	setElementData(source,"logedin",false)
end)