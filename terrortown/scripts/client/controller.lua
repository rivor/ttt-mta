--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

addEvent("startClientTimer",true)

local roundTimer;
local currentRound;

addEventHandler("startClientTimer",root,function(time)
	if isTimer(roundTimer) then killTimer(roundTimer) end
	roundTimer = setTimer(function()end,time,1)
end)

function getTimersTime()
	if (isTimer(roundTimer)) then
		local timeLeft = getTimerDetails(roundTimer)
		timeLeft = math.floor(timeLeft/1000)
		return timeLeft;
	end
	return false;
end

function getCurrentRound()
	if (not currentRound) then
		return false;
	end
	return currentRound;
end

local elem = nil;

addCommandHandler("t",function(src,cmd)
	local x,y,z = getElementPosition(localPlayer)
	elem = createObject(1337,x,y,z)
end)

addEventHandler("onClientRender",root,function()
	if (elem) then
		iprint(getElementVelocity(elem))
		setElementVelocity(elem,1,0,0)
	end
end)