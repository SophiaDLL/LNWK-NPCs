-- DO NOT CHANGE THE BELLOW IF YOU DO NOT KNOW WHAT YOU ARE DOING
local spawnedNPCs = {}
local LocalNPCs = {}
local QBCore = exports["qb-core"]:GetCoreObject()
local previewPed = nil
local previewOffset = vec3(0.0, 2.0, 0.0) -- In front of player
local previewHeading = 0.0
local previewActive = false
local previewData = nil
local verticalOffset = 0.0

local previewRotation = 0.0
local moveOffset = vector3(0.0, 0.0, 0.0)

local playerFrozen = false
local editMode = false
local previewBaseCoords = nil

function startPedPreview(pedData)
    if previewPed and DoesEntityExist(previewPed) then
        DeleteEntity(previewPed)
    end

    previewData = pedData
    local modelHash = pedData.ped and (pedData.gender == "female" and `mp_f_freemode_01` or `mp_m_freemode_01`) or joaat(pedData.model or "S_M_Y_Sheriff_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end

    local playerCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), previewOffset.x, previewOffset.y, previewOffset.z)
    previewPed = CreatePed(4, modelHash, playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(PlayerPedId()), false, true)

    SetEntityAlpha(previewPed, 150, false)
    SetEntityCollision(previewPed, false, false)
    SetEntityInvincible(previewPed, true)
    SetBlockingOfNonTemporaryEvents(previewPed, true)
    FreezeEntityPosition(previewPed, true)

    if pedData.animation and pedData.animation.animationDict and pedData.animation.animation then
        RequestAnimDict(pedData.animation.animationDict)
        print(pedData.animation.animationDict)
        local timeout = GetGameTimer() + 5000
        while not HasAnimDictLoaded(pedData.animation.animationDict) do
            if GetGameTimer() > timeout then
                print("[Ped Preview] Animation dictionary failed to load: " .. pedData.animation.animationDict)
                break
            end
            Wait(0)
        end

        if HasAnimDictLoaded(pedData.animation.animationDict) then
        local flag = 49 -- default fallback

        -- SitChair (original)
        if pedData.animation.animationDict == "timetable@ron@ig_3_couch" and pedData.animation.animation == "base" then
            flag = 1
        -- SitChairAttentive
        elseif pedData.animation.animationDict == "anim@scripted@freemode_npc@fix_astu_ig3_pooh_jimmy@jimmy@"
            and pedData.animation.animation == "sit_base_jimmy" then
            flag = 1
        -- SitChair4 - Side
        elseif pedData.animation.animationDict == "timetable@ron@ron_ig_2_alt1"
            and pedData.animation.animation == "ig_2_alt1_base" then
            flag = 1
        end

        TaskPlayAnim(previewPed, pedData.animation.animationDict, pedData.animation.animation, 8.0, -8.0, -1, flag, 0, false, false, false)
    end

    end

    if pedData.ped and pedData.mpClothing then
        applyMPClothing(previewPed, pedData.mpClothing)
    end

    previewActive = true
    SetNuiFocus(false, false)
    updatePreviewLoop()
end

function raycastMouseCoord()
    local camRot = GetGameplayCamRot(2)
    local camPos = GetGameplayCamCoord()
    local direction = RotationToDirection(camRot)
    local dest = camPos + direction * 200.0

    local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, 1, PlayerPedId(), 0)
    local _, hit, endCoords = GetShapeTestResult(rayHandle)
    return hit == 1, endCoords
end

function RotationToDirection(rot)
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local cosX = math.cos(x)
    return vector3(-math.sin(z) * cosX, math.cos(z) * cosX, math.sin(x))
end

function GetForwardVector(heading)
    local h = math.rad(heading)
    return vector3(math.sin(h), -math.cos(h), 0.0)
end

function GetRightVector(heading, dir)
    local h = math.rad(heading + (dir == -1 and -90 or 90))
    return vector3(math.sin(h), -math.cos(h), 0.0)
end

function updatePreviewLoop()
    CreateThread(function()
        while previewActive and DoesEntityExist(previewPed) do
            local previewCoords
            local playerPed = PlayerPedId()

            -- Toggle Edit Mode
            if IsControlJustReleased(0, 29) then -- B (or CTRL)
                editMode = not editMode
                playerFrozen = editMode
                FreezeEntityPosition(playerPed, editMode)
                SetEntityInvincible(playerPed, editMode)

                if editMode then
                    -- Set a clean base position in front of the player
                    previewBaseCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
                    SetEntityCoords(previewPed, previewBaseCoords.x, previewBaseCoords.y, previewBaseCoords.z, false, false, false, false)
                    moveOffset = vector3(0.0, 0.0, 0.0)
                else
                    previewBaseCoords = nil
                end
            end

            -- Position Logic
            if editMode then
                if previewBaseCoords then
                    previewCoords = previewBaseCoords + moveOffset + vector3(0.0, 0.0, verticalOffset)
                else
                    -- Fallback in case base was nil
                    previewCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, verticalOffset)
                end
            else
                local hit, hitCoords = raycastMouseCoord()
                if hit then
                    previewCoords = vector3(hitCoords.x, hitCoords.y, hitCoords.z + verticalOffset)
                else
                    previewCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, verticalOffset)
                end
            end

            -- Apply to preview ped
            SetEntityCoords(previewPed, previewCoords.x, previewCoords.y, previewCoords.z, false, false, false, false)
            SetEntityHeading(previewPed, previewRotation)

            -- Draw help text
            local label = editMode and "[B] Exit Edit | [WASD] Move | [Q/E] Up/Down | [Arrow Keys] Rotate" or "[B] Edit Mode | Mouse Aim"
            DrawText3D(previewCoords, "[ENTER] Place | [BACKSPACE] Cancel\n" .. label)

            -- Edit Mode Movement
            if editMode then
                if IsControlPressed(0, 32) then -- W
                    moveOffset = moveOffset + GetForwardVector(previewRotation) * 0.02
                end
                if IsControlPressed(0, 33) then -- S
                    moveOffset = moveOffset - GetForwardVector(previewRotation) * 0.02
                end
                if IsControlPressed(0, 34) then -- A
                    moveOffset = moveOffset + GetRightVector(previewRotation, -1) * 0.02
                end
                if IsControlPressed(0, 35) then -- D
                    moveOffset = moveOffset + GetRightVector(previewRotation, 1) * 0.02
                end
            end

            -- Shared Controls
            if IsControlPressed(0, 44) then -- Q
                verticalOffset = verticalOffset + 0.01
            elseif IsControlPressed(0, 38) then -- E
                verticalOffset = verticalOffset - 0.01
            end
            if IsControlPressed(0, 174) then -- LEFT
                previewRotation = previewRotation - 1.0
            elseif IsControlPressed(0, 175) then -- RIGHT
                previewRotation = previewRotation + 1.0
            end

            -- Confirm or Cancel
            if IsControlJustReleased(0, 191) then -- ENTER
                placePreviewPed()
                break
            elseif IsControlJustReleased(0, 202) then -- BACKSPACE
                cancelPreviewPed()
                break
            end

            Wait(0)
        end

        -- Clean up if needed
        if playerFrozen then
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityInvincible(PlayerPedId(), false)
            playerFrozen = false
            editMode = false
        end
    end)
end







function placePreviewPed()
    if not previewPed or not previewData then return end
    local coords = GetEntityCoords(previewPed)
    local heading = GetEntityHeading(previewPed)

    local placedData = table.clone(previewData)
    placedData.coords = { coords.x, coords.y, coords.z }
    placedData.heading = heading

    TriggerServerEvent("falcon:addNewPed", placedData)
    DeleteEntity(previewPed)
    previewPed = nil
    previewActive = false
end

function cancelPreviewPed()
    if previewPed and DoesEntityExist(previewPed) then
        DeleteEntity(previewPed)
    end
    previewPed = nil
    previewActive = false
end

function DrawText3D(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end


RegisterNetEvent("falcon:syncNPCs", function(npcList)
    print("New npcList received from server")
    print(json.encode(npcList))
    LocalNPCs = npcList
end)

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

    -- Fix: immediately apply exact heading and coords again
    SetEntityHeading(ped, npcConfig.heading or 0.0)
    SetEntityCoordsNoOffset(ped, npcConfig.coords[1], npcConfig.coords[2], npcConfig.coords[3], false, false, false)

    SetEntityInvincible(ped, true)
    
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

        if HasAnimDictLoaded(npcConfig.animationDict) then
            local flag = 49 -- default fallback

            -- Sit Chair default
            if npcConfig.animationDict == "timetable@ron@ig_3_couch" and npcConfig.animation == "base" then
                flag = 1
            -- Sit Chair Attentive
            elseif npcConfig.animationDict == "anim@scripted@freemode_npc@fix_astu_ig3_pooh_jimmy@jimmy@"
                and npcConfig.animation == "sit_base_jimmy" then
                flag = 1
            -- Sit Chair 4 - Side
            elseif npcConfig.animationDict == "timetable@ron@ron_ig_2_alt1"
                and npcConfig.animation == "ig_2_alt1_base" then
                flag = 1
            end

            TaskPlayAnim(ped, npcConfig.animationDict, npcConfig.animation, 8.0, -8.0, -1, flag, 0, false, false, false)
        end

    end
    SetEntityHeading(ped, npcConfig.heading or 0.0)
    SetEntityCoordsNoOffset(ped, npcConfig.coords[1], npcConfig.coords[2], npcConfig.coords[3], false, false, false)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    return ped -- Return the created ped
end

CreateThread(function()
    while true do
        Wait(1000)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i = 1, #(LocalNPCs or {}) do
            local npcConfig = LocalNPCs[i]

            local npc = spawnedNPCs[i]
            local npcCoords = vector3(npcConfig.coords[1], npcConfig.coords[2], npcConfig.coords[3])
            local distance = #(playerCoords - npcCoords)
            local npcExists = npc and DoesEntityExist(npc.ped)

            if distance <= 50.0 then
                if not npcExists then
                    print(string.format("Spawning NPC: %s", npcConfig.name))
                    local ped = spawnNPC({
                        name = npcConfig.name,
                        useMPClothing = npcConfig.useMPClothing,
                        useMPGender = npcConfig.useMPGender,
                        model = npcConfig.model,
                        coords = vector3(npcConfig.coords[1], npcConfig.coords[2], npcConfig.coords[3]),
                        heading = npcConfig.coords[4],
                        animationDict = npcConfig.animationDict,
                        animation = npcConfig.animation,
                        enableBlip = npcConfig.enableBlip,
                        blipIcon = npcConfig.blipIcon,
                        mpClothing = npcConfig.mpClothing or { components = {}, props = {} }
                    })
                    spawnedNPCs[i] = { ped = ped, name = npcConfig.name }

                    if npcConfig.enableBlip then
                        local blip = AddBlipForCoord(npcConfig.coords[1], npcConfig.coords[2], npcConfig.coords[3])
                        SetBlipSprite(blip, npcConfig.blipIcon or 1)
                        SetBlipScale(blip, 0.8)
                        SetBlipColour(blip, 1)
                        SetBlipAsShortRange(blip, false)

                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(npcConfig.name or "NPC")
                        EndTextCommandSetBlipName(blip)

                        spawnedNPCs[i].blip = blip
                    end
                end
            else
                if npcExists then
                    print(string.format("Despawning NPC: %s", npcConfig.name))
                    DeleteEntity(npc.ped)
                    if npc.blip then
                        RemoveBlip(npc.blip)
                    end
                    spawnedNPCs[i] = nil
                end
            end
        end
    end
end)

RegisterNetEvent("falcon:removePedByName", function(name)
    for i, npc in pairs(spawnedNPCs) do
        if npc.name and npc.name:lower() == name:lower() then
            if npc.ped and DoesEntityExist(npc.ped) then
                DeleteEntity(npc.ped)
            end
            if npc.blip then
                RemoveBlip(npc.blip)
            end
            spawnedNPCs[i] = nil
            print(("^2Removed spawned NPC: %s^0"):format(name))
            break
        end
    end
end)


AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    for _, npc in pairs(spawnedNPCs) do
        if npc.ped and DoesEntityExist(npc.ped) then
            DeleteEntity(npc.ped)
        end
        if npc.blip then
            RemoveBlip(npc.blip)
        end
    end

    spawnedNPCs = {} -- Clear the table
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

-- RegisterKeyMapping('UI TRUE', 'UI OPEN', 'keyboard', 'CAPITAL')

TriggerEvent('chat:addSuggestion', '/ui', 'Update UI with a message (true/false)', {
    { name = "update", help = "true or false" }
})

RegisterNetEvent("nui:updateMessage", function(msg)
    SendNUIMessage({
        action = "update",
        update = msg
    })
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('open', function()
    SetNuiFocus(true, true)
end)

RegisterNUICallback('spawnPed', function(pedData, cb)
    startPedPreview(pedData)
    cb("ok")
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

CreateThread(function()
    Wait(1000)
    TriggerServerEvent("falcon:requestNPCSync")
end)


-- RegisterCommand("verifyAnims", function()
--     local animsToCheck = {
--         { dict = "anim@mp_player_intcelebrationfemale@slow_clap", name = "slow_clap" },
--         { dict = "amb@world_human_cheering@male_a", name = "base" },
--         { dict = "anim@mp_player_intcelebrationmale@salute", name = "salute" },
--         { dict = "anim@mp_player_intcelebrationfemale@face_palm", name = "face_palm" },
--         { dict = "random@countryside_gang_fight", name = "gangmember_stickup_loop" },
--         { dict = "amb@world_human_stand_mobile@male@text@base", name = "base" },
--         { dict = "switch@trevor@floyd_crying", name = "console_end_loop_floyd" },
--         { dict = "amb@code_human_cross_road@male@base", name = "base" },
--         { dict = "switch@michael@bench", name = "cellphone_call_listen_base" },
--         { dict = "mp_move@prostitute@f@cokehead", name = "idle" },
--         { dict = "mp_clothing@female@shirt", name = "try_shirt_neutral_a" },
--         { dict = "timetable@gardener@smoking_joint", name = "smoke_idle" },
--         { dict = "missheist_agency3aig_23", name = "urinal_asifyouneededproof" },
--         { dict = "amb@medic@standing@kneel@idle_a", name = "idle_a" },
--         { dict = "amb@medic@standing@tendtodead@idle_a", name = "idle_a" },
--         { dict = "amb@world_human_guard_patrol@male@idle_b", name = "idle_e" },
--         { dict = "random@peyote@bird", name = "wakeup" },
--         { dict = "anim@mp_player_intcelebrationfemale@thumbs_up", name = "thumbs_up" },
--         { dict = "anim@mp_player_intcelebrationfemale@photography", name = "photography" },
--         { dict = "random@arrests@busted", name = "idle_a" },
--         { dict = "anim@heists@fleeca_bank@ig_7_jetski_owner", name = "idle_a" },
--         { dict = "amb@world_human_leaning@male@wall@back@hands_together@idle_a", name = "idle_a" },
--         { dict = "amb@world_human_push_ups@male@base", name = "pushups_loop" },
--         { dict = "timetable@ron@ig_5_p3", name = "sit" },
--         -- Replacement for nightclub dance anims
--         { dict = "anim@mp_player_intcelebrationfemale@raining_cash", name = "raining_cash" },
--         { dict = "amb@prop_human_bum_shopping_cart@male@idle_a", name = "idle_a" },
--         { dict = "amb@world_human_hang_out_street@male_b@idle_a", name = "base" },
--         { dict = "dead", name = "dead_a" },
--         { dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", name = "idle_a" },
--         -- Replacement for missing female leaning anim
--         { dict = "amb@world_human_leaning@male@wall@back@idle_a", name = "idle_a" },
--         -- Bench sit fallback already covered via timetable@ron@ig_5_p3
--         { dict = "amb@world_human_picnic@male@idle_a", name = "base" },
--         { dict = "amb@world_human_yoga@male@base", name = "pose_a" },
--         { dict = "rcmcollect_paperleadinout@", name = "idle_c" },
--         { dict = "move_crouch_proto", name = "idle" },
--         { dict = "amb@code_human_wander_clipboard@male@base", name = "idle_a" },
--         { dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a", name = "idle_a" },
--         { dict = "amb@world_human_clipboard@male@idle_a", name = "base" },
--         { dict = "amb@world_human_maid_clean@", name = "base" },
--         { dict = "amb@world_human_clipboard@male@base", name = "idle_a" },
--         { dict = "amb@world_human_hammering@male@base", name = "idle_a" },
--         -- Replacement for bench hammer animation
--         { dict = "amb@world_human_hammering@male@base", name = "idle_a" },
--         -- Replacement for bartender animation
--         { dict = "amb@world_human_bum_standing@drunk@idle_a", name = "idle_a" },
--         { dict = "amb@world_human_drinking@coffee@male@idle_a", name = "idle_a" },
--         -- Dance 3
--         { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", name = "mi_dance_facedj_15_v1_female^1" },
--         { dict = "special_ped@mountain_dancer@base", name = "dance_loop_teddy_bear" },
--         { dict = "anim@mp_player_intcelebrationfemale@find_the_fish", name = "mp_dance_loop" },
--         -- Replacement for slow dance
--         { dict = "anim@mp_player_intcelebrationfemale@peace", name = "peace" },
--         { dict = "anim@move_m@grooving@", name = "shuffle" }
--     }

--     for _, anim in ipairs(animsToCheck) do
--         local dict, name = anim.dict, anim.name
--         RequestAnimDict(dict)

--         local timeWaited = 0
--         while not HasAnimDictLoaded(dict) do
--             Wait(100)
--             timeWaited += 100
--             if timeWaited > 3000 then
--                 print(("❌ Dictionary failed to load: %s"):format(dict))
--                 break
--             end
--         end

--         if HasAnimDictLoaded(dict) then
--             print(("✅ Loaded anim dict: %s | clip: %s"):format(dict, name))
--         else
--             print(("❌ Missing anim dict or clip: %s | %s"):format(dict, name))
--         end
--     end
-- end)
