local spawnedNPCs = {}

function applyMPClothing(ped, clothingConfig)
    for i=1, #(clothingConfig.components) do
        local component = clothingConfig.components[i]
        SetPedComponentVariation(ped, component.componentId, component.drawableId, component.textureId, 0)
    end
    for i=1, #(clothingConfig.props) do
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
    if npcConfig.useMPClothing then
        applyMPClothing(ped, npcConfig.mpClothing)
    end

    RequestAnimDict(npcConfig.animationDict)
    while not HasAnimDictLoaded(npcConfig.animationDict) do
        Wait(0)
    end

    SetBlockingOfNonTemporaryEvents(ped, true)  
    TaskPlayAnim(ped, npcConfig.animationDict, npcConfig.animation, 8.0, -8.0, -1, 1, 0, false, false, false)
    SetModelAsNoLongerNeeded(pedModel)
    RemoveAnimDict(npcConfig.animationDict)
    spawnedNPCs[#spawnedNPCs + 1] = { name = npcConfig.name, ped = ped }
end

CreateThread(function()
   for i=1, #(Config.NPCs) do
        spawnNPC(Config.NPCs[i])
    end

    if GetCurrentResourceName() ~= "PedSpawner" then
        print("Please dont edit the resource name :(")
    end
end)

-- Commands
RegisterCommand('pos', function()
    local playerPed = PlayerPedId() 
    local playerCoords = GetEntityCoords(playerPed)  
    local playerHeading = GetEntityHeading(playerPed)  

    -- Make command display xyz & H
    local coordsString = string.format("Your current position is: X: %.2f, Y: %.2f, Z: %.2f, Heading: %.2f", playerCoords.x, playerCoords.y, playerCoords.z, playerHeading)

    TriggerEvent('chat:addMessage', {
        args = { coordsString }
    })
end, false)  -- Make this TRUE to make it admin only

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for i=1, #spawnedNPCs do
        DeleteEntity(spawnedNPCs[i].ped)
    end
end)
