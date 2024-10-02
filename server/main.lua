local checkVersion = import('modules.version_check')
checkVersion()

local DamageEvent = import('modules.weapon_damage')
local CombatLog = import('modules.combat_log')
local inCombatMode = {}

if Config.CombatMode then
    DamageEvent.onDamaged(function(source, target)
        if not inCombatMode[source] then
            print('Player is in combat')
            inCombatMode[source] = true
        end
        if not inCombatMode[target] then
            inCombatMode[target] = true
        end
        inCombatMode[source] = Config.CombatModeTime
        inCombatMode[target] = Config.CombatModeTime
    end)

    CreateThread(function()
        while true do
            Wait(1000)
            for k,v in pairs(inCombatMode) do
                if not inCombatMode[k] then goto continue end
                if v > 0 then
                    inCombatMode[k] = v - 1
                else
                    inCombatMode[k] = nil
                end
                ::continue::
            end
        end
    end)
end

RegisterCommand('test', function(source)
    local ped = GetPlayerPed(source)
    CombatLog.sendLog(source, GetEntityCoords(ped), 'Exiting')
end, false)

-- Clearing memory
AddEventHandler('playerDropped', function(reason)
    local _source = source
    local ped = GetPlayerPed(_source)
    if inCombatMode[_source] then
        inCombatMode[_source] = nil
        TriggerEvent('fuksus-combatlog:combatLogOff', _source)
    end
    if Config.CombatLog then
        CombatLog.sendLog(_source, GetEntityCoords(ped), reason)
    end
end)

exports('isInCombatMode', function(source)
    return inCombatMode[source] or false
end)