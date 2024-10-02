local checkVersion = import('modules.version_check')
checkVersion()

local DamageEvent = import('modules.weapon_damage')
local CombatLog = import('modules.combat_log')
local inCombatMode = {}

RegisterCommand('randomData', function()
    for i=1, 50 do
        Wait(math.random(1000, 5000))
        inCombatMode[i] = math.random(1, Config.CombatModeTime)
    end
end, false)

if Config.CombatMode then
    DamageEvent.onDamaged(function(source, target)
        if not inCombatMode[source] then
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