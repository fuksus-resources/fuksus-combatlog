local cachedPlayers = {}
local CombatLog = {}

CombatLog.sendLog = function(source)
    TriggerClientEvent('fuksus-combatlog:sendLog', -1, cachedPlayers[source])
end

CreateThread(function()
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        cachedPlayers[playerId] = {
            name = name,
            source = playerId
        }
    end
end)

RegisterNetEvent('fuksus-combatlog:addCache', function()
    local _source = source
    local name = GetPlayerName(_source)
    cachedPlayers[_source] = {
        name = name,
        source = _source
    }
end)

return CombatLog
