Config = {}

Config.Locale = 'en'

Config.CombatLog = true
Config.CombatLogTimeout = 30 -- This is seconds
Config.CombatLogEntity = `s_m_m_strperf_01` -- If nil there would be no entity
Config.CombatLogShowDistance = 4.0
Config.CombatMode = true
Config.CombatModeTime = 10 -- This is seconds

Config.DrawDistance = 50.0

Config.Marker = {
    type = 32,
    color = { r = 0, g = 255, b = 0, a = 100 },
    scale = { x = 1.0, y = 2.0, z = 1.0 },
    rotate = false,
    bobUpAndDown = true,
    faceCamera = false,
}