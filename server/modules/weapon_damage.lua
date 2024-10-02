local IsPedAPlayer = IsPedAPlayer
local DamageEvent = {}
DamageEvent.callbacks = {}

DamageEvent.onDamaged = function(cb)
    DamageEvent.callbacks[#DamageEvent.callbacks + 1] = {
        resource = GetInvokingResource(),
        cb = cb
    }
end

DamageEvent.triggerLoaded = function(...)
    for k,v in pairs(DamageEvent.callbacks) do
        if v.resource == GetInvokingResource() then
            v.cb(...)
        end
    end
end

AddEventHandler('weaponDamageEvent', function(source, data)
    if not data.hitGlobalId then return end
    local ped = NetworkGetEntityFromNetworkId(data.hitGlobalId)
    if not IsPedAPlayer(ped) then return end
    local target = NetworkGetEntityOwner(ped)
    if not target then return end
    local _source = source
    DamageEvent.triggerLoaded(_source, target)
end)

return DamageEvent