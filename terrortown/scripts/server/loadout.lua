--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 01 May 2017.
--<----------------------->--

local playerLoadout = {
	first = { -- automatic gun
		25,27,29,31,33,30
	},
	second = { -- pistol gun
		24,
	},
	third = { -- meele weapon
		2,3,5,7,8,15
	}
}

function giveLoadout(player)
	takeAllWeapons(player);
	local pick1 = math.random(#playerLoadout.first)
	local pick1Wep = playerLoadout.first[pick1]
	giveWeapon(player,pick1Wep,math.random(75,250),true)
	local pick2 = math.random(#playerLoadout.second)
	local pick2Wep = playerLoadout.second[pick2]
	giveWeapon(player,pick2Wep,math.random(50,150),false)
	local pick3 = math.random(#playerLoadout.third)
	local pick3Wep = playerLoadout.third[pick3]
	giveWeapon(player,pick3Wep,1,false)
end