local CombatLog = import('modules.draw_combatlog')

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('fuksus-combatlog:addCache')
end)

RegisterNetEvent('fuksus-combatlog:sendLog', function(data)
    CombatLog.add(data)
end)