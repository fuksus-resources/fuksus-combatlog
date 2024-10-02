local Entity = {}

Entity.create = function(coords)
    lib.requestModel(Config.CombatLogEntity)
    local entity = CreatePed(1, Config.CombatLogEntity, coords.x, coords.y, coords.z - 1.0, 0.0, false, true)
    SetModelAsNoLongerNeeded(Config.CombatLogEntity)
    SetEntityInvincible(entity, true)
    FreezeEntityPosition(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityAlpha(entity, 102, false)

    return entity
end

return Entity