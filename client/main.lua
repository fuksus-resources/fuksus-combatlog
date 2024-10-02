local combatLogs = {}

RegisterNetEvent('fuksus-combatlog:sendLog', function(data)
    combatLogs[#combatLogs + 1] = data
end)