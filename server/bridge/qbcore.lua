if GetResourceState('qb-core') ~= 'started' then return end
print(('[^6%s^7] [^5INFO^7] Loaded QBCore configuration'):format(GetInvokingResource() or GetCurrentResourceName()))
bridge = {}

local QBCore = exports['qb-core']:GetCoreObject()