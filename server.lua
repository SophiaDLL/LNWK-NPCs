local function addNewPed(source, pedName, pedType, pedGender, animationDict, animation, enableBlip, blipIcon, pedModel)
    -- Debugging Information
    print("Adding new ped with data:")
    print("Name:", pedName)
    print("Type (MP/SP):", pedType)
    print("Gender:", pedGender)
    print("Enable Blip:", enableBlip)
    print("Blip Icon:", blipIcon)
    print("Model received:", pedModel)

    -- Defaults and Validations
    pedModel = pedModel or (pedType and (pedGender == "male" and "mp_m_freemode_01" or "mp_f_freemode_01") or "S_M_Y_Sheriff_01")
    enableBlip = enableBlip or false
    blipIcon = blipIcon or 1

    if not pedName or not pedGender then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^8ERROR', 'Invalid syntax. Use /PlacePed "name" "type" "gender" "model"' }
        })
        return
    end

    if pedGender:lower() ~= "male" and pedGender:lower() ~= "female" then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^8ERROR', 'Invalid gender. Use "male" or "female".' }
        })
        return
    end

    -- Player location and heading
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    -- Format the ped configuration
    local pedConfig = string.format(
        [[
        {
            name = "%s",
            useMPClothing = %s,
            useMPGender = "%s",
            model = "%s",
            coords = vector4(%.2f, %.2f, %.2f, %.2f),
            animationDict = "%s",
            animation = "%s",
            enableBlip = %s,
            blipIcon = %d,
            mpClothing = { 
                components = {
                    { componentId = 1, drawableId = 3, textureId = 0 },
                    { componentId = 3, drawableId = 0, textureId = 0 },
                    { componentId = 4, drawableId = 18, textureId = 0 },
                    { componentId = 5, drawableId = 0, textureId = 0 },
                    { componentId = 6, drawableId = 0, textureId = 0 },
                    { componentId = 7, drawableId = 0, textureId = 0 },
                    { componentId = 8, drawableId = 10, textureId = 0 },
                    { componentId = 9, drawableId = 0, textureId = 0 },
                    { componentId = 10, drawableId = 0, textureId = 0 },
                    { componentId = 11, drawableId = 23, textureId = 0 }
                },
                props = {
                    { propId = 0, drawableId = 5, textureId = 0 },
                    { propId = 1, drawableId = 0, textureId = 0 },
                    { propId = 2, drawableId = 0, textureId = 0 },
                    { propId = 6, drawableId = 0, textureId = 0 },
                    { propId = 7, drawableId = 0, textureId = 0 }
                }
            }
        }]],
        pedName,
        tostring(pedType),
        pedGender,
        pedModel,
        playerCoords.x, playerCoords.y, playerCoords.z - 1.0, heading,
        animationDict or "default_animation_dict",
        animation or "default_animation",
        tostring(enableBlip),
        blipIcon
    )

    -- Save to config.lua
    local resourceName = GetCurrentResourceName()
    local configPath = "config.lua"
    local existingConfig = LoadResourceFile(resourceName, configPath)

    if not existingConfig then
        print("^1Error: Failed to load config.lua. Make sure it exists.^0")
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1Error', 'Failed to load config.lua. Make sure it exists.' }
        })
        return
    end

    local updatedConfig = existingConfig:gsub("(Config.NPCs%s*=%s*%{)", "%1\n" .. pedConfig .. ",")
    local success = SaveResourceFile(resourceName, configPath, updatedConfig, -1)

    if success then
        print("^2Success: Ped configuration saved successfully!^0")
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^2Success', 'Ped configuration saved successfully!' }
        })
    else
        print("^1Error: Failed to save ped configuration.^0")
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1Error', 'Failed to save Ped configuration.' }
        })
    end
end

RegisterCommand('PlacePed', function(source, args, rawCommand)
    local pedName = args[1]
    local pedType = args[2] == "true"
    local pedGender = args[3]
    local pedModel = args[4] -- Optional model parameter

    if not pedName or not pedGender then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^8ERROR', 'Invalid syntax. Use /PlacePed "name" "type" "gender" "model"' }
        })
        return
    end

    addNewPed(source, pedName, pedType, pedGender, nil, nil, false, 1, pedModel)
end, false)

RegisterNetEvent("addNewPed", function(pedData)
    local src = source
    print("Received ped data from client:", json.encode(pedData))

    local pedName = pedData.name
    local pedType = pedData.ped
    local pedGender = pedData.gender
    local animationDict = pedData.animation and pedData.animation.animationDict or nil
    local animation = pedData.animation and pedData.animation.animation or nil
    local enableBlip = pedData.enableBlip
    local blipIcon = pedData.blipIcon
    local pedModel = pedData.model

    addNewPed(src, pedName, pedType, pedGender, animationDict, animation, enableBlip, blipIcon, pedModel)
end)

TriggerEvent('chat:addSuggestion', '/PlacePed', 'Add a new ped to config.lua', {
    { name = "name", help = "Ped Name (e.g., Test)" },
    { name = "type", help = "Ped Type (true for MP, false for SP)" },
    { name = "gender", help = "Ped Gender (male or female)" },
    { name = "model", help = "Ped Model (e.g., S_M_Y_Sheriff_01)" }
})

-- Key-Value Pairs Example (optional feature for future use)
-- local data = json.encode(theConfig)
-- SetResourceKvp("pedConfig", data)

-- local data = json.decode(GetResourceKvpString("pedConfig"))
