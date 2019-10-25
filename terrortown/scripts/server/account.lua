--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

addEventHandler("onPlayerLogin",root,function(prevAccount,account)
	--cancelEvent()
	setElementData(source,"logedin",true)
	setElementData(source,"showhud",true)
	setElementData(source,"role","none")
	fadeCamera(source,true)
	setCameraTarget(source,source)
	setDefaultStats(source)
end)

function setDefaultStats(player)
	for i=69,79 do
		setPedStat(player,i,999)
	end
end

addCommandHandler("kill",function(source)
	killPed(source)
end)