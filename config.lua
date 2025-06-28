Config = {}

Config.NPCs = {
        {
            name = "Testing 2",
            useMPClothing = false,
            useMPGender = "Female",
            model = "a_f_m_bevhills_02",
            coords = vector4(-50.10, 941.50, 231.22, 308.98),
            animationDict = "anim@mp_player_intcelebrationfemale@slow_clap",
            animation = "slow_clap",
            enableBlip = false,
            blipIcon = 1,
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
        },
        {
            name = "Party",
            useMPClothing = false,
            useMPGender = "Female",
            model = "a_f_y_clubcust_02",
            coords = vector4(-50.82, 940.67, 231.22, 79.37),
            animationDict = "amb@world_human_stand_mobile@male@text@base",
            animation = "base",
            enableBlip = false,
            blipIcon = 1,
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
        },
        {
            name = "Test 1",
            useMPClothing = false,
            useMPGender = "Male",
            model = "a_f_m_ktown_01",
            coords = vector4(97.58, -1600.17, 28.68, 17.01),
            animationDict = "switch@michael@bench",
            animation = "cellphone_call_listen_base",
            enableBlip = false,
            blipIcon = 1,
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
        },
    -- {
    --     name = "Police NPC Male", -- Name for the NPC This can be ANYTHING
    --     useMPClothing = false, -- Enable//Disable MP Clothing usage
    --     useMPGender = "male", -- if you set to male = MP_M if you set to female = MP_F
    --     model = "S_M_Y_Sheriff_01", -- If UseMPClothing is false, this will be the Spawned Ped ( https://forge.plebmasters.de/peds )
    --     coords = vector4(428.21, -981.27, 29.71, 88.54), -- Sets the Ped Location X,y,z,H
    --     animationDict = "amb@world_human_maid_clean@base", -- Animation Directory  ( https://forge.plebmasters.de/animations )
    --     animation = "base", -- Animations  ( https://forge.plebmasters.de/animations )
    --     enableBlip = false,
    --     blipIcon = 8,
    --     mpClothing = {
    --         components = {  -- This is all clothing  (This applys for mp/sp peds)
    --             { componentId = 1, drawableId = 3, textureId = 0 }, -- Masks
    --             { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
    --             { componentId = 4, drawableId = 18, textureId = 0 }, -- Legs
    --             { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
    --             { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
    --             { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
    --             { componentId = 8, drawableId = 10, textureId = 0 }, -- Undershirts
    --             { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
    --             { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
    --             { componentId = 11, drawableId = 23, textureId = 0 } -- Tops
    --         },
    --         props = { -- This is all props
    --             { propId = 0, drawableId = 5, textureId = 0 }, -- Hats
    --             { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
    --             { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
    --             { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
    --             { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
    --         }
    --     }
    -- },
    -- {
    --     name = "Police NPC Female", -- Name for the NPC This can be ANYTHING
    --     useMPClothing = false, -- Enable//Disable MP Clothing usage
    --     useMPGender = "female", -- if you set to male = MP_M if you set to female = MP_F
    --     model = "S_F_Y_Sheriff_01", -- If UseMPClothing is false, this will be the Spawned Ped ( https://forge.plebmasters.de/peds )
    --     coords = vector4(428.51, -978.83, 29.71, 92.47), -- Sets the Ped Location X,y,z,H
    --     animationDict = "anim@heists@heist_corona@single_team", -- Animation Directory  ( https://forge.plebmasters.de/animations )
    --     animation = "single_team_loop_boss",  -- Animations  ( https://forge.plebmasters.de/animations )
    --     enableBlip = false,
    --     blipIcon = 8,
    --     mpClothing = {
    --         components = {  -- This is all clothing  (This applys for mp/sp peds)
    --             { componentId = 1, drawableId = 0, textureId = 0 }, -- Masks
    --             { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
    --             { componentId = 4, drawableId = 1, textureId = 0 }, -- Legs
    --             { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
    --             { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
    --             { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
    --             { componentId = 8, drawableId = 15, textureId = 0 }, -- Undershirts
    --             { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
    --             { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
    --             { componentId = 11, drawableId = 24, textureId = 0 } -- Tops
    --         },
    --         props = { -- This is all props
    --             { propId = 0, drawableId = 5, textureId = 0 }, -- Hats
    --             { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
    --             { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
    --             { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
    --             { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
    --         }
    --     }
    -- }
}
