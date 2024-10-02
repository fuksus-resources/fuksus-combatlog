local combatLogs = {}

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('fuksus-combatlog:addCache')
end)

RegisterNetEvent('fuksus-combatlog:sendLog', function(data)
    combatLogs[#combatLogs + 1] = data
end)