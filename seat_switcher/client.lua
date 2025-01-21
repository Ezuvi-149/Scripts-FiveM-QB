local QBCore = exports['qb-core']:GetCoreObject()

local function OpenSeatMenu()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if not DoesEntityExist(vehicle) then return end
    
    local vehicleModel = GetEntityModel(vehicle)
    local maxSeats = GetVehicleModelNumberOfSeats(vehicleModel)
    
    local menuItems = {
        {
            header = "Cambiar de asiento",
            isMenuHeader = true
        }
    }
    
    for i = -1, maxSeats - 2 do
        local seatName
        if i == -1 then
            seatName = "Conductor"
        elseif i == 0 then
            seatName = "Copiloto"
        else
            seatName = "Asiento " .. tostring(i + 1)
        end
        
        if IsVehicleSeatFree(vehicle, i) then
            table.insert(menuItems, {
                header = seatName,
                params = {
                    event = "qb-seatswitcher:switchSeat",
                    args = {
                        seatIndex = i
                    }
                }
            })
        end
    end
    
    exports['qb-menu']:openMenu(menuItems)
end

RegisterNetEvent('qb-seatswitcher:switchSeat')
AddEventHandler('qb-seatswitcher:switchSeat', function(data)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if DoesEntityExist(vehicle) and data.seatIndex ~= nil then
        SetPedIntoVehicle(playerPed, vehicle, data.seatIndex)
    end
end)

RegisterCommand('cambiarasiento', function()
    OpenSeatMenu()
end, false)

RegisterKeyMapping('cambiarasiento', 'Abrir menú de cambio de asiento', 'keyboard', '§')
