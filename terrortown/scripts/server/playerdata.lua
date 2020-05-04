--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 08 May 2017.
--<----------------------->--

plyData = {};

addEvent("syncServer",true)

addEventHandler("syncServer",localPlayer,function(ply,data,value)
	setPlayerData(ply,data,value)
end)

function syncClient(ply,data,value)
	triggerClientEvent(root,"syncClient",root,ply,data,value)
end

function setPlayerData(ply,data,value,sync)
	if (not sync) then sync = true; end
	if (not plyData[ply]) then plyData[ply] = {}; end
	plyData[ply][data] = value;
	if (sync) then
		syncClient(ply,data,value);
	end
end

function getPlayerData(ply,data)
	return plyData[ply][data];
end
