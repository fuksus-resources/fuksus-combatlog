local marker = Config.Marker
local CombatLog = {}
local combatLogs = {}

CombatLog.add = function(data, coords)
    local point = lib.points.new({
        coords = coords,
        distance = Config.DrawDistance,
        data = data,
        timeout = Config.CombatLogTimeout,
    })

    function point:nearby()
        DrawMarker(marker.type, self.coords.x, self.coords.y, self.coords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 2, marker.rotate, nil, nil, false)
    end

    combatLogs[#combatLogs+1] = point
end

CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(combatLogs) do
            if not combatLogs[k] then goto continue end
            if v.timeout > 0 then
                v.timeout = v.timeout - 1
            else
                combatLogs[k].remove(combatLogs[k])
                combatLogs[k] = nil
            end
            ::continue::
        end
    end
end)

return CombatLog