--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

local roundTimer;
local currentRound;

-- this will save all current manager process in element datas (nothing important, only to let client know what states we are in)
createElement("dummies","controller");

function startTimer(time,func)
	triggerClientEvent(root,"startClientTimer",root,time)
	if isTimer(roundTimer) then killTimer(roundTimer) end
	roundTimer = setTimer(function()
		func();
	end,time,1)
end

function getTimersTime()
	if (isTimer(roundTimer)) then
		local timeLeft = getTimerDetails(roundTimer)
		return math.floor(timeLeft/1000)
	end
	return false;
end

function getCurrentRound()
	if (not currentRound) then
		return false;
	end
	return currentRound;
end

function setRoundState(state)
	setElementData(getElementByID("controller"),"state",state)
end

function getRoundState()
	return getElementData(getElementByID("controller"),"state")
end

function getTraitorCount()
	local players = #getOnlinePlayers();
	local traitor_count = math.floor(players*0.2);
	if (players > 1 and traitor_count < 1) then traitor_count = 1 end
	traitor_count = 1
	return traitor_count;
end

function getDetectiveCount()
	local players = #getOnlinePlayers();
	local detective_count = math.floor(players*0.13);
	if (detective_count < 1) then detective_count = 1 end
	return detective_count;
end

function setRole(player,role)
	setElementData(player,"role",role);
	if (role == ROLE_INNOCENT) then
		fadeCamera(player,false,0.3,0,255,0);
		setTimer(fadeCamera,125,1,player,true,0.3,0,255,0);
	elseif (role == ROLE_DETECTIVE) then
		fadeCamera(player,false,0.3,0,0,255);
		setTimer(fadeCamera,125,1,player,true,0.3,0,0,255);
		triggerClientEvent(root,"createPedBubble",root,player,0,0,1)
	elseif (role == ROLE_TRAITOR) then
		fadeCamera(player,false,0.3,255,0,0);
		setTimer(fadeCamera,125,1,player,true,0.3,255,0,0);
		triggerClientEvent(player,"createPedBubble",player,player,1,0,0)
	end
end

function getRole(player)
	return getElementData(player,"role");
end

function selectRoles()
	local choices = {};
	local prev_roles = {};
	for _,v in pairs(getOnlinePlayers()) do
		table.insert(choices,v);
	end
	if (#choices == 0) then return end
	local traitor_count = getTraitorCount();
	local detective_count = getDetectiveCount();
	-- select traitors
	if (#choices < 1) then return; end
	local selected_traitors = 0;
	while selected_traitors < traitor_count do
		local pick = math.random(#choices);
		local selected = choices[pick];
		setRole(selected,ROLE_TRAITOR);
		table.remove(choices,pick)
		selected_traitors = selected_traitors+1;
	end
	-- select detectives
	if (#choices < 1) then return; end
	local selected_detectives = 0;
	while selected_detectives < detective_count do
		local pick = math.random(#choices);
		local selected = choices[pick];
		setRole(selected,ROLE_DETECTIVE);
		table.remove(choices,pick)
		selected_detectives = selected_detectives+1;
	end
	-- select innocents
	if (#choices < 1) then return; end
	local selected_innocents = 0;
	while selected_innocents < #choices do
		local pick = math.random(#choices);
		local selected = choices[pick];
		setRole(selected,ROLE_INNOCENT);
		table.remove(choices,pick)
		selected_innocents = selected_innocents+1;
	end
end

function startRound()
	if (not currentRound) then
		currentRound = 0;
	end
	currentRound = currentRound+1;
	selectRoles()
	startTimer(CONFIG.ROUND_TIME*60000,endRound)
	setRoundState("Playing")
	local spawnpoints = getMapSpawnPoints();
	for _,v in pairs(getOnlinePlayers()) do
		local pick = math.random(#spawnpoints)
		local spawnid,x,y,z,rot = unpack(spawnpoints[pick])
		spawnPlayer(v,x,y,z,rot,math.random(50))
		table.remove(spawnpoints,pick)
		giveLoadout(v)
		if (karmaData[v]) then
			setKarma(v,karmaData[v])
		end
	end
end

function endRound()
	startTimer(CONFIG.ROUND_END_TIME*1000,prepareRound)
	setRoundState("Finished")
	for _,v in pairs(getOnlinePlayers()) do
		takeAllWeapons(v)
	end
end

function prepareRound()
	setRoundState("Preparing")
	startTimer(CONFIG.ROUND_PREPARE_TIME*1000,startRound)
end