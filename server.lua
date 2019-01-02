ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('tidning', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('tidningen', source)

end)

RegisterServerEvent('getidning')
AddEventHandler('getidning', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local tidning = xPlayer.getInventoryItem('tidning').count

    if tidning < 1 then
    xPlayer.addInventoryItem('tidning', 1)
    TriggerClientEvent("esx:showNotification", src, "You picked up a newspaper!")
    else
        TriggerClientEvent("esx:showNotification", src, "You already have a newspaper!")
    end
end)