ESX = nil
IsAnimated = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end
end)



Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)

        local entity, distance = ESX.Game.GetClosestObject({
            "prop_news_disp_02a",
            "prop_news_disp_01a",
            "prop_news_disp_02b",
            "prop_news_disp_03a",
            "prop_news_disp_02c",
            "prop_news_disp_03c"

        })

        if distance ~= -1 and distance <= 2 then
            if entity ~= nil then
                local mailCoords = GetEntityCoords(entity)
                ESX.Game.Utils.DrawText3D({ x = mailCoords.x, y = mailCoords.y, z = mailCoords.z + 1 }, '~g~[E]~s~ Grab newspaper', 0.5)
                if IsControlJustReleased(0, 38) then
                        tidning()
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

function tidning()
    if not IsPedInAnyVehicle(PlayerPedId()) then
    TriggerEvent("tidning:animation")
    Citizen.Wait(1500)
    TriggerServerEvent("getidning")
    else
    ESX.ShowNotification("You cannot do this in a vehicle")
    end
  
end


RegisterNetEvent('tidningen')
AddEventHandler('tidningen', function()
    if not IsAnimated then
        prop_name = prop_name or 'prop_cs_newspaper'
        IsAnimated = true
        Citizen.Wait(500)

    end
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(playerPed))
        local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(playerPed, 6286)

        local lPed = GetPlayerPed(-1)
        local dict = "missmic3"
        
            LoadAnimationDictionary("missmic3")
            TaskPlayAnim(lPed, "missmic3", "newspaper_dialogue_idle_dave", 8.0, 8.0, -1, 49, 0, false, false, false)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, 0.248, -0.351, 14.0, 100.0, 15.0, true, true, false, true, 1, true)
            Citizen.Wait(20000)
            IsAnimated = false
            ClearPedSecondaryTask(playerPed)
            DeleteObject(prop)
            DetachEntity(prop, true, false) 
    end)
	
end)

RegisterNetEvent('tidning:animation')
AddEventHandler('tidning:animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(750)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)
