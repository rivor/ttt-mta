--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 01 May 2017.
--<----------------------->--

addEventHandler("onPlayerLogin",root,function()
	setKarma(source,CONFIG.DEFAULT_KARMA);
end)

function setKarma(player,karma)
	if (karma < 1) then karma = 1; end
	if (karma > 1000) then karma = 1000; end
	setElementData(player,"karma",karma)
end

function getKarma(player)
	return getElementData(player,"karma");
end

addEventHandler("onPlayerWasted",root,function(_,killer,weapon,bodypart,stealth)
	--setTimer(spawnPlayer,1500,1,source,0,0,3)
	if (isElement(killer) and getElementType(killer) == "player") then
		local killersRole = getRole(killer);
		local killersKarma = getKarma(killer)
		local targetsRole = getRole(source);
		-- add karma if killer kills correct target
		local reward = math.random(50,100)
		if (killersRole == ROLE_TRAITOR) then
			if (killersRole ~= targetsRole) then karmaData[killer] = killersKarma+reward; end
		else
			if (targetsRole == ROLE_TRAITOR) then
				karmaData[killer] = killersKarma+reward;
			end
		end
		-- remove karma if killer kills wrong target
		local penalty = math.random(50,150)
		if (killersRole == ROLE_TRAITOR) then
			if (killersRole == targetsRole) then karmaData[killer] = killersKarma-penalty; end
		else
			if (targetsRole == ROLE_INNOCENT or targetsRole == ROLE_DETECTIVE) then
				karmaData[killer] = killersKarma-penalty;
			end
		end
	end
	local players = getAlivePlayers()
	local detectives = {}
	local traitors = {}
	local innocents = {}
	for k,v in pairs(players) do
		if getRole(v) == ROLE_DETECTIVE then table.insert(detectives,v) end
		if getRole(v) == ROLE_TRAITOR then table.insert(traitors,v) end
		if getRole(v) == ROLE_INNOCENT then table.insert(innocents,v) end
	end
	if (#traitors == 0) then
		outputChatBox("Innocents win!", root, 20, 200, 20)
		endRound()
	elseif (#detectives == 0 and #innocents == 0) then
		outputChatBox("Traitors win!", root, 200, 20, 20)
		endRound()
	end
	if (#players == 0) then
		endRound()
	end
end)

function rewardTraitor(credits)

end