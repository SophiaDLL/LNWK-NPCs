-- DO NOT CHANGE THE BELLOW IF YOU DO NOT KNOW WHAT YOU ARE DOING
local spawnedNPCs = {}

function applyMPClothing(ped, clothingConfig)
    for i = 1, #(clothingConfig.components) do
        local component = clothingConfig.components[i]
        SetPedComponentVariation(ped, component.componentId, component.drawableId, component.textureId, 0)
    end
    for i = 1, #(clothingConfig.props) do
        local prop = clothingConfig.props[i]
        SetPedPropIndex(ped, prop.propId, prop.drawableId, prop.textureId, true)
    end
end

function spawnNPC(npcConfig)
    local pedModel
    if npcConfig.useMPClothing then
        pedModel = npcConfig.useMPGender == "female" and `mp_f_freemode_01` or `mp_m_freemode_01`
    else
        pedModel = joaat(npcConfig.model)
    end

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(0)
    end

    local ped = CreatePed(4, pedModel, npcConfig.coords, npcConfig.heading, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityCanBeDamaged(ped, false)
    SetEntityProofs(ped, true, true, true, true, true, true, true, true)
    SetPedDefaultComponentVariation(ped)

    if npcConfig.useMPClothing then
        applyMPClothing(ped, npcConfig.mpClothing)
    end

    if npcConfig.animationDict and npcConfig.animation then
        RequestAnimDict(npcConfig.animationDict)
        while not HasAnimDictLoaded(npcConfig.animationDict) do
            Wait(0)
        end
        TaskPlayAnim(ped, npcConfig.animationDict, npcConfig.animation, 8.0, -8.0, -1, 49, 0, false, false, false)
    end

    SetBlockingOfNonTemporaryEvents(ped, true)
    return ped -- Return the created ped
end

CreateThread(function()
    while true do
        Wait(1000) -- Check every second

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i = 1, #(Config.NPCs) do
            local npcConfig = Config.NPCs[i]

            -- Retrieve the NPC from `spawnedNPCs`
            local npc = spawnedNPCs[i]

            -- Check if NPC exists and calculate distance
            local npcCoords = vector3(npcConfig.coords.x, npcConfig.coords.y, npcConfig.coords.z)
            local distance = #(playerCoords - npcCoords)
            local npcExists = npc and DoesEntityExist(npc.ped)

            -- Spawn NPC if within range and not already spawned
            if distance <= 50.0 then
                if not npcExists then
                    print(string.format("Spawning NPC: %s", npcConfig.name))

                    -- Spawn the NPC and add to `spawnedNPCs`
                    local ped = spawnNPC(npcConfig)
                    spawnedNPCs[i] = { ped = ped, name = npcConfig.name }

                    -- Add a blip if enabled
                    if npcConfig.enableBlip then
                        local blip = AddBlipForCoord(npcConfig.coords.x, npcConfig.coords.y, npcConfig.coords.z)
                        SetBlipSprite(blip, npcConfig.blipIcon or 1) -- Default to icon 1
                        SetBlipScale(blip, 0.8)
                        SetBlipColour(blip, 1) -- Default color (red)
                        SetBlipAsShortRange(blip, false)

                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(npcConfig.name or "NPC")
                        EndTextCommandSetBlipName(blip)

                        -- Store the blip in `spawnedNPCs`
                        spawnedNPCs[i].blip = blip
                    end
                end
            else
                -- Despawn NPC if out of range
                if npcExists then
                    print(string.format("Despawning NPC: %s", npcConfig.name))

                    -- Delete the NPC
                    DeleteEntity(npc.ped)

                    -- Remove the associated blip
                    if npc.blip then
                        RemoveBlip(npc.blip)
                    end

                    -- Remove the NPC entry from `spawnedNPCs`
                    spawnedNPCs[i] = nil
                end
            end
        end


        if GetCurrentResourceName() ~= "LNWK-NPCs" then
            print("Please dont edit the resource name :(")
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for i = 1, #spawnedNPCs do
        DeleteEntity(spawnedNPCs[i].ped)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        ExecuteCommand('sets tags "LNWK Peds"')
    end
end)

-- Bellow this point will contain all Commands.
RegisterCommand('vec4', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    local positionText = string.format("vec4(%.2f, %.2f, %.2f, %.2f)", playerCoords.x, playerCoords.y,
        playerCoords.z - 1.0, playerHeading)

    -- NUI
    SendNUIMessage({
        action = "copyToClipboard",
        text = positionText
    })

    -- noty
    TriggerEvent("chat:addMessage", {
        args = { "Position copied to clipboard: " .. positionText }
    })
end, false)

RegisterCommand('vec3', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    local positionText = string.format("vec3(%.2f, %.2f, %.2f)", playerCoords.x, playerCoords.y, playerCoords.z - 1.0)

    -- NUI
    SendNUIMessage({
        action = "copyToClipboard",
        text = positionText
    })

    -- noty
    TriggerEvent("chat:addMessage", {
        args = { "Position copied to clipboard: " .. positionText }
    })
end, false)

RegisterCommand('vec2', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    local positionText = string.format("vec2(%.2f, %.2f)", playerCoords.x, playerCoords.y)

    -- NUI
    SendNUIMessage({
        action = "copyToClipboard",
        text = positionText
    })

    -- noty
    TriggerEvent("chat:addMessage", {
        args = { "Position copied to clipboard: " .. positionText }
    })
end, false)

RegisterKeyMapping('UI TRUE', 'UI OPEN', 'keyboard', 'CAPITAL')

TriggerEvent('chat:addSuggestion', '/ui', 'Update UI with a message (true/false)', {
    { name = "update", help = "true or false" }
})

RegisterCommand('ui', function(source, args)
    local update = args[1] or "No update message"
    SendNUIMessage({
        action = "update",
        update = update
    })
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('open', function()
    SetNuiFocus(true, true)
end)

RegisterNUICallback('spawnPed', function(pedData, cb)
    TriggerServerEvent("addNewPed", pedData)
    cb("")
end)

RegisterNUICallback('getPlayerCoords', function(_, cb)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Send the coordinates and heading back to JS
    cb({
        x = playerCoords.x,
        y = playerCoords.y,
        z = playerCoords.z,
        h = playerHeading
    })
end)



