--<----------------------->--
-- * Trouble in Terrorist Town
-- * Authors: Shader file by CCW, this script file by kaasis.
-- * Date: 01 May 2017.
--<----------------------->--

local shaders = {} -- stores player shader's bubble

addEvent("createPedBubble",true)
addEvent("setPedBubbleColor",true)
addEvent("destroyPedBubble",true)

addEventHandler("onClientPlayerQuit",root,function()
	if (shaders[source]) then shaders[source] = nil; end
end)

addEventHandler("createPedBubble",localPlayer,function(ply,r,g,b)
	local shader;
	if (not shaders[ply]) then
		shader = dxCreateShader("shaders/ped_shell_layer.fx",0,0,true,"ped");
	else
		shader = shaders[ply];
	end
	if (not shader) then
		outputChatBox("Shader failed to create! Please reconnect or restart your MTA.",200,20,20)
	else
		engineApplyShaderToWorldTexture(shader,"*",ply)
		engineRemoveShaderFromWorldTexture(shader,"muzzle_texture4",ply)
		dxSetShaderValue(shader,"sMorphSize",0.03,0.03,0.03)
		dxSetShaderValue(shader,"sMorphColor",r,g,b,1)
		shaders[ply] = shader;
	end
end)

addEventHandler("setPedBubbleColor",localPlayer,function(ply,r,g,b)
	if (ply and shaders[ply]) then
		dxSetShaderValue(shaders[ply],"sMorphColor",r,g,b,1)
	end
end)

addEventHandler("destroyPedBubble",localPlayer,function(ply)
	if (ply) then
		engineRemoveShaderFromWorldTexture(shaders[ply],"*",ply)
	end
end)
