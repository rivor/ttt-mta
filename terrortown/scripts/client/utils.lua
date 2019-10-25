--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

sW,sH = guiGetScreenSize();

COLOR_INNOCENT = tocolor(20,200,20,150)
COLOR_DETECTIVE = tocolor(20,20,200,150)
COLOR_TRAITOR = tocolor(200,20,20,150)
COLOR_GRAY = tocolor(200,200,200,150)

local size = 12;
local textRound = dxCreateTexture("assets/images/round.png","argb",true,"clamp")
local textFull = dxCreateTexture("assets/images/full.png","argb",true,"clamp")

function dxDrawRoundBox(x,y,w,h,color,postGUI)
	if (w <= 25) then w = 25 end
	dxDrawImage(x,y,size,size,textRound,0,0,0,color,postGUI)
	dxDrawImage(x+size,y,w-size*2,size,textFull,0,0,0,color,postGUI)
	dxDrawImage(x+w-size,y,size,size,textRound,90,0,0,color,postGUI)
	dxDrawImage(x,y+size,size,h-size*2,textFull,0,0,0,color,postGUI)
	dxDrawImage(x+w-size,y+h-size,size,size,textRound,180,0,0,color,postGUI)
	dxDrawImage(x+w-size,y+size,size,h-size*2,textFull,0,0,0,color,postGUI)
	dxDrawImage(x,y+h-size,size,size,textRound,270,0,0,color,postGUI)
	dxDrawImage(x+size,y+h-size,w-size*2,size,textFull,0,0,0,color,postGUI)
	dxDrawImage(x+size,y+size,w-size*2,h-size*2,textFull,0,0,0,color,postGUI)
end

-- FROM WIKI.MTASA.COM --
function isMouseInPosition(x,y,width,height)
	if (not isCursorShowing()) then
		return false
	end
	local cx,cy = getCursorPosition()
	local cx,cy = (cx*sW),(cy*sH)
	if (cx >= xandcx <= x+width) and (cy >= yandcy <= y+height) then
		return true
	else
		return false
	end
end

function formatTime(value)
	if value then
		local firstValue = math.floor(value/60);
		local secondValue = tonumber(("%.0f"):format(((value/60)-math.floor(value/60))*100/(100/60)));
		if (firstValue < 10) then firstValue = "0"..firstValue; end
		if (secondValue < 10) then secondValue = "0"..secondValue; end
		return firstValue..":"..secondValue;
	end
	return false;
end
-- FROM WIKI.MTASA.COM --

function getOnlinePlayers()
	return #getElementsByType("player");
end

function valueToRelative(defValue,currValue)
	return currValue/defValue
end