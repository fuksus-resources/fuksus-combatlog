local checkVersion = import('modules.version_check')
checkVersion()

local DamageEvent = import('modules.weapon_damage')
local CombatLog = import('modules.combat_log')
local inCombatMode = {}

if Config.CombatMode then
    DamageEvent.onDamage(function(source, target)
        if not inCombatMode[source] then
            inCombatMode[source] = true
        end
        if not inCombatMode[target] then
            inCombatMode[target] = true
        end
        inCombatMode[source] = Config.CombatModeTime
        inCombatMode[target] = Config.CombatModeTime
    end)
end

-- Clearing memory
AddEventHandler('playerDropped', function()
    local _source = source
    if inCombatMode[_source] then
        inCombatMode[_source] = nil
    end
    if Config.CombatLog then
        CombatLog.sendLog(_source)
    end
end)

exports('isInCombatMode', function(source)
    return inCombatMode[source] or false
end)