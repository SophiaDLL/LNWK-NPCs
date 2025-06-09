local QBCore = exports["qb-core"]:GetCoreObject()

local function loadNPCData()
    local jsonData = LoadResourceFile(GetCurrentResourceName(), "npcs.json") or "[]"
    return json.decode(jsonData)
end

local function saveNPCData(data)
    SaveResourceFile(GetCurrentResourceName(), "npcs.json", json.encode(data, { indent = true }), -1)
end

local function broadcastNPCData()
    local allNPCs = loadNPCData()
    TriggerClientEvent("falcon:syncNPCs", -1, allNPCs)
end

local function addNewPed(source, pedName, pedType, pedGender, animationDict, animation, enableBlip, blipIcon, pedModel, coords, heading)
    print("Adding new ped with data:")
    print("Name:", pedName, "Type:", pedType, "Gender:", pedGender, "Model:", pedModel)

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

    -- Use preview coords if provided, else default to player position
    local pos = coords or { x = 0, y = 0, z = 0 }
    local pedHeading = heading or 0.0

    if not coords then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        pedHeading = GetEntityHeading(playerPed)
        pos = { x = playerCoords.x, y = playerCoords.y, z = playerCoords.z - 1.0 }
    end

    local newPed = {
        name = pedName,
        useMPClothing = pedType,
        useMPGender = pedGender,
        model = pedModel,
        coords = { pos.x, pos.y, pos.z, pedHeading },
        animationDict = animationDict or "default_animation_dict",
        animation = animation or "default_animation",
        enableBlip = enableBlip,
        blipIcon = blipIcon,
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
    }

    local npcList = loadNPCData()
    table.insert(npcList, newPed)
    saveNPCData(npcList)
    broadcastNPCData()

    TriggerClientEvent('chat:addMessage', source, {
        args = { '^2Success', 'Ped configuration saved and synced!' }
    })
end

RegisterNetEvent("falcon:addNewPed", function(pedData)
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
    local coords = pedData.coords and {
        x = pedData.coords[1],
        y = pedData.coords[2],
        z = pedData.coords[3]
    } or nil
    local heading = pedData.heading or nil

    addNewPed(src, pedName, pedType, pedGender, animationDict, animation, enableBlip, blipIcon, pedModel, coords, heading)
end)


local function removePedByName(pedName)
    local npcList = loadNPCData()
    local updatedList = {}

    local removed = false
    for _, npc in ipairs(npcList) do
        if npc.name:lower() ~= pedName:lower() then
            table.insert(updatedList, npc)
        else
            removed = true
        end
    end

    saveNPCData(updatedList)
    return removed
end

RegisterCommand('PlacePed', function(source, args)
    local pedName = args[1]
    local pedType = args[2] == "true"
    local pedGender = args[3]
    local pedModel = args[4]
    local src = source

    local Player = QBCore.Functions.HasPermission(src, "admin") or QBCore.Functions.HasPermission(src, "god")
    if not Player then return end

    if not pedName or not pedGender then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^8ERROR', 'Invalid syntax. Use /PlacePed "name" "type" "gender" "model"' }
        })
        return
    end

    addNewPed(src, pedName, pedType, pedGender, nil, nil, false, 1, pedModel)
end, false)

RegisterCommand('ui', function(source, args)
    local src = source
    local Player = QBCore.Functions.HasPermission(src, "admin") or QBCore.Functions.HasPermission(src, "god")
    if not Player then return end

    local update = table.concat(args, " ") or "No update message"
    TriggerClientEvent("nui:updateMessage", src, update)
end)

RegisterCommand("RemovePed", function(source, args)
    local src = source
    local Player = QBCore.Functions.HasPermission(src, "admin") or QBCore.Functions.HasPermission(src, "god")
    if not Player then return end

    local nameToRemove = args[1]
    if not nameToRemove then
        TriggerClientEvent('chat:addMessage', src, {
            args = { '^8ERROR', 'Usage: /RemovePed "name"' }
        })
        return
    end

    local removed = removePedByName(nameToRemove)
    if removed then
        TriggerClientEvent('chat:addMessage', src, {
            args = { '^2Success', ('Removed NPC named "%s".'):format(nameToRemove) }
        })
        broadcastNPCData()
        TriggerClientEvent("falcon:removePedByName", -1, nameToRemove)
    else
        TriggerClientEvent('chat:addMessage', src, {
            args = { '^8ERROR', ('No NPC found with name "%s".'):format(nameToRemove) }
        })
    end
end, false)

TriggerEvent('chat:addSuggestion', '/RemovePed', 'Remove a saved ped by name', {
    { name = "name", help = "Name of the ped to remove" }
})

-- Suggestion help
TriggerEvent('chat:addSuggestion', '/PlacePed', 'Add a new ped to npcs.json', {
    { name = "name", help = "Ped Name (e.g., Test)" },
    { name = "type", help = "Ped Type (true for MP, false for SP)" },
    { name = "gender", help = "Ped Gender (male or female)" },
    { name = "model", help = "Ped Model (e.g., S_M_Y_Sheriff_01)" }
})

-- Auto-sync on player load
RegisterNetEvent("QBCore:Server:PlayerLoaded", function()
    local src = source
    local npcs = loadNPCData()
    TriggerClientEvent("falcon:syncNPCs", src, npcs)
end)

-- Optionally sync all on resource start
AddEventHandler("onResourceStart", function(res)
    if res == GetCurrentResourceName() then
        Wait(3000)
        broadcastNPCData()
    end
end)

RegisterNetEvent("falcon:requestNPCSync", function()
    local src = source
    local GlobalNPCList = loadNPCData()
    TriggerClientEvent("falcon:syncNPCs", src, GlobalNPCList)
end)

