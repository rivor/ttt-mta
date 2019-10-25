--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

function getOnlinePlayers()
	return getElementsByType("player");
end

--[[function getAlivePlayers()
	local players = {}
	for k,v in pairs(getOnlinePlayers()) do
		if (not isPedDead(v)) then
			table.insert(players,v)
		end
	end
	return players
end]]--