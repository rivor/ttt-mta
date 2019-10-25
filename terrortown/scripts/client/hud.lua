local hudOffset,hudX,hudY,hudW,hudH = 10,0,sH-150,250,150
local fontAkrobatBlack = dxCreateFont("assets/fonts/Akrobat-Black.otf",50)
local meeleSlots = {[0]=true,[1]=true,[10]=true}

local tttGroupColor = {
	["Innocent"] = COLOR_INNOCENT,
	["Detective"] = COLOR_DETECTIVE,
	["Traitor"] = COLOR_TRAITOR,
	["Preparing"] = COLOR_GRAY,
	["Spectating"] = COLOR_GRAY,
	["Round over"] = COLOR_GRAY,
}

addEventHandler("onClientRender",root,function()
	if getElementData(localPlayer,"logedin") and getElementData(localPlayer,"showhud") then
		-- THIS IS HUD BOX THAT DRAWS BOTTOM RIGHT CORNER (P.S I MADE THIS ON FAST, THAT'S WHY CODE IS SHIT ;D)
		local boxW,boxH = 225,125
		local boxW2,boxH2 = 225,31
		local font1 = 0.35
		local tttKarmaFontSize = 1;
		-- support for shitty monitors :D
		if (sW <= 800 and sH <= 600) then
			boxW,boxH = sW*0.18,sH*0.16
			boxW2,boxH2 = sW*0.18,sH*0.0407
			font1 = (sW+sH)*0.00017
			tttKarmaFontSize = (sW+sH)*0.00059
		end
		--
		local font2 = font1-0.05
		local boxMargin = 10
		local realBoxX,realBoxY = boxMargin,sH-boxH-boxMargin
		local tttBarShadow = 1;
		local tttKarma = "Karma ["..getElementData(localPlayer,"karma").."]";
		local tttCredits = "Credits ["..tostring(1).."]";
		local tttKarmaFont = "sans";
		local tttKarmaFontHeight = dxGetFontHeight(tttKarmaFontSize,tttKarmaFont);
		local tttKarmaTextWidth = dxGetTextWidth(tttKarma,tttKarmaFontSize,tttKarmaFont)
		local tttCreditsTextWidth = dxGetTextWidth(tttCredits,tttKarmaFontSize,tttKarmaFont)
		local tttGroup = getElementData(localPlayer,"role");
		if (getElementData(getElementByID("controller"),"state") == "Preparing" or getElementData(getElementByID("controller"),"state") == "Finished" or getElementData(localPlayer,"isDead")) then
			if (getElementData(getElementByID("controller"),"state") == "Preparing") then
				tttGroup = getElementData(getElementByID("controller"),"state")
			elseif (getElementData(getElementByID("controller"),"state") == "Finished") then
				tttGroup = "Round over"
			elseif getElementData(localPlayer,"isDead") then
				tttGroup = "Spectating"
			end
			local tttTime = formatTime(getTimersTime() or 0);
			local tttBarW,tttBarH = boxW*0.65,boxH*0.23
			boxW,boxH = boxW2,boxH2;
			realBoxX,realBoxY = boxMargin,sH-boxH-boxMargin
			dxDrawRoundBox(realBoxX,realBoxY,boxW,boxH,tocolor(10,10,10,225),false)
			dxDrawRoundBox(realBoxX,realBoxY,boxW*0.65+tttBarShadow*2,tttBarH+tttBarShadow*2,tocolor(0,0,0,225),false)
			dxDrawRoundBox(realBoxX+tttBarShadow,realBoxY+tttBarShadow,tttBarW,tttBarH,tttGroupColor[tttGroup],false)
			dxDrawText(tttGroup,realBoxX+tttBarShadow,realBoxY+tttBarShadow,tttBarW+boxMargin,realBoxY+tttBarH,tocolor(255,255,255),font1,fontAkrobatBlack,"center","center",true)
			dxDrawText(tttTime,realBoxX+tttBarW,realBoxY+tttBarShadow,tttBarW+boxW*0.35+boxMargin,realBoxY+tttBarH,tocolor(255,255,255),font2,fontAkrobatBlack,"center","center",true)
		else
			local tttTime = formatTime(getTimersTime() or 0);
			local tttBarW,tttBarH = boxW*0.65,boxH*0.23
			local tttHealth = math.floor(getElementHealth(localPlayer))
			local tttWepAmmo = getPedAmmoInClip(localPlayer).." + "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)
			dxDrawRoundBox(realBoxX,realBoxY,boxW,boxH,tocolor(10,10,10,225),false)
			dxDrawRoundBox(realBoxX,realBoxY,boxW*0.65+tttBarShadow*2,tttBarH+tttBarShadow*2,tocolor(0,0,0,225),false)
			dxDrawRoundBox(realBoxX+tttBarShadow,realBoxY+tttBarShadow,tttBarW,tttBarH,tttGroupColor[tttGroup],false)
			dxDrawText(tttGroup,realBoxX+tttBarShadow,realBoxY+tttBarShadow,tttBarW+boxMargin,realBoxY+tttBarH,tocolor(255,255,255),font1,fontAkrobatBlack,"center","center",true)
			dxDrawText(tttTime,realBoxX+tttBarW,realBoxY+tttBarShadow,tttBarW+boxW*0.35+boxMargin,realBoxY+tttBarH,tocolor(255,255,255),font2,fontAkrobatBlack,"center","center",true)
			
			dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin-tttBarShadow,realBoxY+boxH*0.325-tttBarShadow,boxW-boxMargin*tttBarShadow*2+tttBarShadow*2,tttBarH+tttBarShadow*2,tocolor(0,0,0,225),false)
			dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin,realBoxY+boxH*0.325,(boxW-boxMargin*tttBarShadow*2),tttBarH,tocolor(200,50,50,50),false)
			dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin,realBoxY+boxH*0.325,(boxW-boxMargin*tttBarShadow*2)*valueToRelative(100,getElementHealth(localPlayer)),tttBarH,tocolor(200,50,50,150),false)
			dxDrawText(tttHealth,realBoxX+tttBarShadow+boxMargin,realBoxY+boxH*0.32+tttBarShadow,tttBarW+boxW*0.35-boxMargin,realBoxY+boxH*0.325+tttBarH,tocolor(255,255,255),font2,fontAkrobatBlack,"right","center",false)
			
			dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin-tttBarShadow,realBoxY+boxH*0.65-tttBarShadow,boxW-boxMargin*tttBarShadow*2+tttBarShadow*2,tttBarH+tttBarShadow*2,tocolor(0,0,0,225),false)
			if (not meeleSlots[getPedWeaponSlot(localPlayer)]) then
				dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin,realBoxY+boxH*0.65,(boxW-boxMargin*tttBarShadow*2),tttBarH,tocolor(250,250,25,50),false)
				dxDrawRoundBox(realBoxX-tttBarShadow+boxMargin,realBoxY+boxH*0.65,(boxW-boxMargin*tttBarShadow*2)*valueToRelative(getWeaponProperty(getPedWeapon(localPlayer),"poor","maximum_clip_ammo"),getPedAmmoInClip(localPlayer)),tttBarH,tocolor(250,250,25,150),false)
				dxDrawText(tttWepAmmo,realBoxX+tttBarShadow+boxMargin,realBoxY+boxH*0.645+tttBarShadow,tttBarW+boxW*0.35-boxMargin,realBoxY+boxH*0.65+tttBarH,tocolor(255,255,255),font2,fontAkrobatBlack,"right","center",false)
			end

			realBoxY = realBoxY-2.5 -- make it go more up from the box :D
			local sansOffset = 0;
			if (tttKarmaFont == "sans") then sansOffset = 1; end

			dxDrawRectangle(realBoxX+boxMargin,realBoxY-tttKarmaFontHeight,tttKarmaTextWidth,tttKarmaFontHeight,tocolor(10,10,10,225))
			--dxDrawText(tttKarma,realBoxX+boxMargin+1,realBoxY-tttKarmaFontHeight+1,boxW+1,realBoxY+1,tocolor(0,0,0,200),tttKarmaFontSize,tttKarmaFont,"left","center",true)
			dxDrawText(tttKarma,realBoxX+boxMargin,realBoxY-tttKarmaFontHeight-sansOffset,boxW,realBoxY-sansOffset,tocolor(255,255,255,200),tttKarmaFontSize,tttKarmaFont,"left","center",true)
			if (tttGroup == "Traitor" or tttGroup == "Detective") then
				dxDrawRectangle(realBoxX+boxW-boxMargin-tttCreditsTextWidth,realBoxY-tttKarmaFontHeight,tttCreditsTextWidth,tttKarmaFontHeight,tocolor(10,10,10,225))
				--dxDrawText(tttCredits,realBoxX+boxMargin+1,realBoxY-tttKarmaFontHeight+1,boxW+1,realBoxY+1,tocolor(0,0,0,200),tttKarmaFontSize,tttKarmaFont,"right","center",true)
				dxDrawText(tttCredits,realBoxX+boxMargin,realBoxY-tttKarmaFontHeight-sansOffset,boxW,realBoxY-sansOffset,tocolor(255,255,255,200),tttKarmaFontSize,tttKarmaFont,"right","center",true)
			end
		end
	end
end)