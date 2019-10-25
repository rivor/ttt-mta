--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 01 May 2017.
--<----------------------->--

addEventHandler("onClientPlayerDamage",localPlayer,function(attacker,weapon,bodypart,loss)
	cancelEvent();
	local karma;
	if (isElement(attacker) and getElementType(attacker) == "player") then
		karma = getElementData(attacker,"karma");
	end
	if (not karma) then karma = 1000; end
	local damage = loss*karma/1000
	setElementHealth(source,getElementHealth(source)-damage)
end)