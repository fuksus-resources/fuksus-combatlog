if GetResourceState('es_extended') ~= 'started' then return end
print(('[^6%s^7] [^5INFO^7] Loaded ESX configuration'):format(GetInvokingResource() or GetCurrentResourceName()))
bridge = {}

local ESX = exports['es_extended']:getSharedObject()