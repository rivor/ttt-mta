--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 03 May 2017.
--<----------------------->--

local map = {
	currentmap = "",
	spawnpoints = {},
}

addEvent("onGamemodeMapStart",false)
addEvent("onGamemodeMapStop",false)
addEvent("onGamemodeMapChange",false)

addEventHandler("onGamemodeMapStart",resourceRoot,function()
	prepareRound()
end)

function isMap(res)
	local restype = getResourceInfo(res,"type")
	if (restype == "map") then
		return true;
	end
	return false;
end

function isMapCompatible(res)
	local gamemodes = tostring(getResourceInfo(res,"gamemodes"))
	local thisGamemode = tostring(getResourceInfo(getThisResource(),"name"))
	if string.find(gamemodes,thisGamemode) then
		return true;
	end
	return false;
end

function getMaps()
	local maps = {};
	for _,map in pairs(getResources()) do
		if isMap(map) and isMapCompatible(map) then
			table.insert(maps,map)
		end
	end
	return maps;
end

function setCurrentMap(mapname)
	map.currentmap = mapname;
end

function getCurrentMap()
	return map.currentmap;
end

function insertMapSpawnPoints()
	map.spawnpoints = {}
	for _,v in pairs(getElementsByType("spawnpoint",res)) do
		local id = getElementData(v,"id")
		local posX = getElementData(v,"posX")
		local posY = getElementData(v,"posY")
		local posZ = getElementData(v,"posZ")
		local rot = getElementData(v,"rotation")
		table.insert(map.spawnpoints,{id,posX,posY,posZ,rot})
	end
end

function getMapSpawnPoints()
	return map.spawnpoints;
end

addEventHandler("onResourcePreStart",root,function(res)
	if isMap(res) then
		local name = getResourceName(res)
		if isMapCompatible(res) then
			outputChatBox("Map "..name.." is compatible and is starting!",root,20,150,0)
		else
			outputChatBox("Map "..name.." is not compatible and has stopped!",root,150,20,20)
			cancelEvent()
		end
	end
end)

addEventHandler("onResourceStart",root,function(res)
	if isMap(res) then
		triggerEvent("onGamemodeMapStart",resourceRoot,res)
		local name = getResourceName(res)
		outputChatBox("Map "..name.." has started!",root,20,150,0)
		setCurrentMap(name)
		insertMapSpawnPoints()
	end
end)

function commandMaplist(ply,cmd,page)
	local maplist = {}
	local showcount = 15
	for _,map in ipairs(getMaps()) do
		table.insert(maplist,getResourceInfo(map,"name"))
	end
	if (not page) then page = 1 end
	local page = tonumber(page);
	local totalpages = #maplist/showcount
	if (totalpages < 1 and #maplist > 1) then totalpages = 1; end
	-- this is probably ugly way to do it, but i'm not sure how to do it other way. :D
	if (math.floor(totalpages) < totalpages and totalpages+1 > math.floor(totalpages)) then
		totalpages = math.floor(totalpages)+1
	end
	--
	-- clear console a bit :D
	for i=1,showcount do
		outputConsole("\n",ply)
	end
	--
	outputConsole("== Page "..page.." out of "..totalpages..".",ply)
	if (page > 1) then page = math.floor(page*showcount-showcount+1) end
	for i=page,page+showcount-1 do
		if (not maplist[i]) then
			break;
		end
		outputConsole(i..". "..maplist[i],ply)
	end
	if (#maplist) == 0 then
		outputConsole("No maps found.",ply)
	end
	outputChatBox("Check your console to see printed maps",ply,20,200,20)
end

addCommandHandler("ttt_maplist",function(source,cmd,page)
	commandMaplist(source,page)
end)

addCommandHandler("ttt_changemap",function(source,cmd,map)
	-- body
end)