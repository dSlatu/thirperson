if SERVER then return end

local Touche = KEY_T
local DefautPremierPersonne = false


local convar = CreateClientConVar("Slatu 3eme Personne", "1", true, false)
if DefautPremierPersonne then
    convar:SetBool(false)
else
    convar:SetBool(true)
end
hook.Add("PlayerButtonUp","Module : réaction touche",function(_,action)
    if action ~= Touche then return end
    timer.Create("Temp patch for glitch vision",0.0001,1,function()
        if not convar:GetBool() then
            convar:SetBool(true)
        else
            convar:SetBool(false)
        end
    end)
end)

hook.Add("CalcView", "Module : affichage du client", function(ply, pos, angles, fov)
    if convar:GetBool() then
        local view = {
            origin = pos - ( angles:Forward() * 100 ),
            angles = angles,
            fov = fov,
            drawviewer = true
        }
        return view
    else
        return
    end
end)
