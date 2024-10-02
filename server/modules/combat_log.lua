local cachedPlayers = {}
local CombatLog = {}

CombatLog.sendLog = function(source, coords, reason)
    if not cachedPlayers[tonumber(source)] then return end
    cachedPlayers[tonumber(source)].reason = reason
    cachedPlayers[tonumber(source)].coords = coords
    cachedPlayers[tonumber(source)].time = os.date('%H:%M:%S')
    TriggerClientEvent('fuksus-combatlog:sendLog', -1, cachedPlayers[tonumber(source)])
end

CreateThread(function()
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        print('Cached player', playerId, name)
        cachedPlayers[tonumber(playerId)] = {
            name = name,
            source = playerId,
            license = GetPlayerIdentifierByType(playerId, 'license'),
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
