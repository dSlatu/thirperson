if SERVER then return end

local Touche = KEY_F1
local DefautPremierPersonne = false

local convarName = "thirdperson_enabled" 


local convar = CreateClientConVar(convarName, "1", true, false)

if DefautPremierPersonne then
    convar:SetBool(false)
else
    convar:SetBool(true)
end


local function ToggleThirdPerson()
    convar:SetBool(not convar:GetBool())
    if convar:GetBool() then

    else

    end
end


concommand.Add("slatu_thirdperson", ToggleThirdPerson)

hook.Add("PlayerButtonUp", "Module: reaction touche", function(_, action)
    if action ~= Touche then return end
    timer.Simple(0.0001, function() 

        ToggleThirdPerson()
    end)
end)

hook.Add("CalcView", "Module: affichage du client", function(ply, pos, angles, fov)
    if convar:GetBool() then
        local view = {
            origin = pos - (angles:Forward() * 100),
            angles = angles,
            fov = fov,
            drawviewer = true
        }
        return view
    end
end)

local function OnPlayerChat(ply, text, teamChat, isDead)

    if not IsValid(ply) or not ply:IsPlayer() then return end

    if string.lower(text) == "!slatu_thirdperson" then
    
        ToggleThirdPerson()
        return true 
    end
end
hook.Add("OnPlayerChat", "ThirdPersonChatCommand", OnPlayerChat)
