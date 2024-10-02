local marker = Config.Marker
local CombatLog = {}
local combatLogs = {}
local Entity = import('modules.entity')
local entities = {}

local function DrawText3D(coords, text, customEntry)
    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start)
    end

    if customEntry ~= nil then
        AddTextEntry(customEntry, str)
        BeginTextCommandDisplayHelp(customEntry)
    else
        AddTextEntry(GetCurrentResourceName(), str)
        BeginTextCommandDisplayHelp(GetCurrentResourceName())
    end
    EndTextCommandDisplayHelp(2, false, false, -1)

    SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z + 0.9)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

CombatLog.add = function(data)
    local point = lib.points.new({
        coords = data.coords,
        distance = Config.DrawDistance,
        data = data,
        timeout = Config.CombatLogTimeout,
    })

    function point:nearby()
        if self.currentDistance <= Config.CombatLogShowDistance then
            DrawText3D(self.coords, string.format('~r~%s~w~\n%s: ~y~%s~w~\n%s: ~p~%s~w~\n%s: ~p~%s~w~\n%s: ~b~%s~w~', L('disconnected'), L('reason'), self.data.reason, L('source'), self.data.source, L('license'), self.data.license, L('left.time'), self.data.time))
            if not entities[self.id] then
                entities[self.id] = Entity.create(self.coords)
            end
        else
            DrawMarker(marker.type, self.coords.x, self.coords.y, self.coords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 2, marker.rotate, nil, nil, false)
            if entities[self.id] then
                DeletePed(entities[self.id])
                entities[self.id] = nil
            end
        end
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
                -- Race condtion
                Wait(400)
                if entities[v.id] then
                    DeletePed(entities[v.id])
                    entities[v.id] = nil
                end
                combatLogs[k] = nil
            end
            ::continue::
        end
    end
end)

return CombatLog