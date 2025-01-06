local elevatorMarker = 22 
local interactionDistance = 1.5

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local sleep = 1000 

        for _, elevator in ipairs(Config.Elevators) do
            for _, floor in ipairs(elevator.floors) do
                local distance = #(playerCoords - floor.coords)

                if distance < 10.0 then
                    sleep = 0 
                    DrawMarker(
                        elevatorMarker,
                        floor.coords.x, floor.coords.y, floor.coords.z - 1.0,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        1.0, 1.0, 1.0,
                        255, 255, 0, 100,
                        false, false, 2, false, nil, nil, false
                    )
                end

                if distance < interactionDistance then
                    sleep = 0 
                    ShowHelpNotification("Press ~INPUT_CONTEXT~ to use the elevator")

                    if IsControlJustPressed(0, 38) then 
                        OpenElevatorMenu(playerPed, elevator.floors)
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

function OpenElevatorMenu(playerPed, floors)
    local elements = {}

    for _, floor in ipairs(floors) do
        table.insert(elements, {label = floor.label, value = floor.coords})
    end
    local selectedFloor = ShowSimpleMenu(elements)

    if selectedFloor then
        TeleportToFloor(playerPed, selectedFloor)
    end
end

function ShowSimpleMenu(elements)
    local selected = nil
    for i, element in ipairs(elements) do
        print(string.format("%d: %s", i, element.label))
    end
    print("Enter the floor number:")
    local input = tonumber(GetUserInput())
    if input and elements[input] then
        selected = elements[input].value
    end
    return selected
end

function TeleportToFloor(playerPed, coords)
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
    SetEntityHeading(playerPed, 0.0)
end

function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
    if GetCurrentResourceName() ~= "LNWK-NPCs" then
        print("Please dont edit the resource name :(")
    end
end

AddEventHandler('onResourceStart', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        ExecuteCommand('sets tags "LNWK Elevators"')
    end
end)

function GetUserInput()
    AddTextEntry('FMMC_KEY_TIP1', "Enter a number:")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 10)

    while UpdateOnscreenKeyboard() == 0 do
        Wait(0)
    end

    if GetOnscreenKeyboardResult() then
        return GetOnscreenKeyboardResult()
    end

    return nil
end
