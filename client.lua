local spawnedNPCs = {}

function applyMPClothing(ped, clothingConfig)
    for _, component in ipairs(clothingConfig.components) do
        SetPedComponentVariation(ped, component.componentId, component.drawableId, component.textureId, 0)
    end
    for _, prop in ipairs(clothingConfig.props) do
        SetPedPropIndex(ped, prop.propId, prop.drawableId, prop.textureId, true)
    end
end

function spawnNPC(npcConfig)
    local pedModel
    if npcConfig.useMPClothing then
        pedModel = npcConfig.useMPGender == "female" and `mp_f_freemode_01` or `mp_m_freemode_01`
    else
        pedModel = GetHashKey(npcConfig.model)
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
    table.insert(spawnedNPCs, { name = npcConfig.name, ped = ped })
end

CreateThread(function()
    for _, npc in ipairs(Config.NPCs) do
        spawnNPC(npc)
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
