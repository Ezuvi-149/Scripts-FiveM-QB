local QBCore = exports['qb-core']:GetCoreObject()

local function OpenSeatMenu()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if not DoesEntityExist(vehicle) then return end
    
    local isBike = IsThisModelABike(GetEntityModel(vehicle))
    
    local elements = {}
    
    if isBike then
        elements = {
            {header = "Conductor", params = {event = "seat_switcher:changeSeat", args = {seat = -1}}},
            {header = "Pasajero", params = {event = "seat_switcher:changeSeat", args = {seat = 0}}}
        }
    else
        elements = {
            {header = "Conductor", params = {event = "seat_switcher:changeSeat", args = {seat = -1}}},
            {header = "Copiloto", params = {event = "seat_switcher:changeSeat", args = {seat = 0}}},
            {header = "Asiento trasero izquierdo", params = {event = "seat_switcher:changeSeat", args = {seat = 1}}},
            {header = "Asiento trasero derecho", params = {event = "seat_switcher:changeSeat", args = {seat = 2}}}
        }
    end
    
    exports['qb-menu']:openMenu(elements)
end

RegisterNetEvent('seat_switcher:changeSeat')
AddEventHandler('seat_switcher:changeSeat', function(data)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if DoesEntityExist(vehicle) then
        SetPedIntoVehicle(playerPed, vehicle, data.seat)
    end
end)

RegisterCommand('cambiarasiento', function()
    OpenSeatMenu()
end, false)

RegisterKeyMapping('cambiarasiento', 'Abrir menú de cambio de asiento', 'keyboard', 'K')
