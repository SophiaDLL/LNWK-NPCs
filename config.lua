Config = {}

Config.NPCs = {
    {
        name = "Police NPC Male", -- Name for the NPC This can be ANYTHING
        useMPClothing = true, -- Enable//Disable MP Clothing usage
        useMPGender = "male", -- if you set to male = MP_M if you set to female = MP_F
        model = "s_f_y_ranger_01", -- If UseMPClothing is false, this will be the Spawned Ped ( https://forge.plebmasters.de/peds )
        coords = vector4(428.47, -981.45, 29.71, 90), -- Sets the Ped Location X,y,z,H
        animationDict = "anim@heists@heist_corona@single_team", -- Animation Directory  ( https://forge.plebmasters.de/animations )
        animation = "single_team_loop_boss", -- Animations  ( https://forge.plebmasters.de/animations )
        mpClothing = {
            components = {  -- This is all clothing  (This applys for mp/sp peds)
                { componentId = 1, drawableId = 3, textureId = 0 }, -- Masks
                { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
                { componentId = 4, drawableId = 18, textureId = 0 }, -- Legs
                { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
                { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
                { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
                { componentId = 8, drawableId = 10, textureId = 0 }, -- Undershirts
                { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
                { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
                { componentId = 11, drawableId = 23, textureId = 0 } -- Tops
            },
            props = { -- This is all props
                { propId = 0, drawableId = 5, textureId = 0 }, -- Hats
                { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
                { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
                { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
                { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
            }
        }
    },
    {
        name = "Police NPC Female", -- Name for the NPC This can be ANYTHING
        useMPClothing = false, -- Enable//Disable MP Clothing usage
        useMPGender = "female", -- if you set to male = MP_M if you set to female = MP_F
        model = "a_f_y_business_04", -- If UseMPClothing is false, this will be the Spawned Ped ( https://forge.plebmasters.de/peds )
        coords = vector4(428.47, -979.45, 29.71, 90), -- Sets the Ped Location X,y,z,H
        animationDict = "anim@heists@heist_corona@single_team", -- Animation Directory  ( https://forge.plebmasters.de/animations )
        animation = "single_team_loop_boss",  -- Animations  ( https://forge.plebmasters.de/animations )
        mpClothing = {
            components = {  -- This is all clothing  (This applys for mp/sp peds)
                { componentId = 1, drawableId = 0, textureId = 0 }, -- Masks
                { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
                { componentId = 4, drawableId = 1, textureId = 0 }, -- Legs
                { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
                { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
                { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
                { componentId = 8, drawableId = 15, textureId = 0 }, -- Undershirts
                { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
                { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
                { componentId = 11, drawableId = 24, textureId = 0 } -- Tops
            },
            props = { -- This is all props
                { propId = 0, drawableId = 5, textureId = 0 }, -- Hats
                { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
                { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
                { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
                { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
            }
        }
    }
}
