--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 08 May 2017.
--<----------------------->--

plyData = {};

addEvent("syncClient",true)

addEventHandler("syncClient",localPlayer,function(ply,data,value)
	setPlayerData(ply,data,value,false)
end)

function syncServer(ply,data,value)
	triggerServerEvent("syncServer",localPlayer,ply,data,value)
end

function setPlayerData(ply,data,value,sync)
	if (sync == nil) then sync = true; end
	plyData[ply][data] = value;
	if (sync) then
		syncServer(ply,data,value);
	end
end

function getPlayerData(ply,data)
	return plyData[ply][data];
end