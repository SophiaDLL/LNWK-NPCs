        Config = {}

        Config.NPCs = {
            {
                name = "Police NPC",
                useMPClothing = false,
                model = "s_f_y_ranger_01", -- If UseMPClothing this will be the Spawned Ped
                coords = vector4(441.39, -978.85, 29.69, 180),
                -- https://forge.plebmasters.de/animations Use Plebmasters to get the animation directory & The animatrion name. 
                animationDict = "anim@heists@heist_corona@single_team",
                animation = "single_team_loop_boss", 
                mpClothing = {
                    components = {
                        { componentId = 1, drawableId = 0, textureId = 0 }, -- Masks
                        { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
                        { componentId = 4, drawableId = 1, textureId = 0 }, -- Legs
                        { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
                        { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
                        { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
                        { componentId = 8, drawableId = 15, textureId = 0 }, -- Undershirts
                        { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
                        { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
                        { componentId = 11, drawableId = 15, textureId = 0 } -- Tops
                    },
                    props = {
                        { propId = 0, drawableId = 3, textureId = 0 }, -- Hats
                        { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
                        { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
                        { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
                        { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
                    }
                }
            },
            {
                name = "Police NPC",
                useMPClothing = false,
                model = "s_f_y_ranger_01", -- If UseMPClothing this will be the Spawned Ped
                coords = vector4(433.32, -985.68, 29.71, 45),
                -- https://forge.plebmasters.de/animations Use Plebmasters to get the animation directory & The animatrion name. 
                animationDict = "anim@heists@heist_corona@single_team",
                animation = "single_team_loop_boss", 
                mpClothing = {
                    components = {
                        { componentId = 1, drawableId = 0, textureId = 0 }, -- Masks
                        { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
                        { componentId = 4, drawableId = 1, textureId = 0 }, -- Legs
                        { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
                        { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
                        { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
                        { componentId = 8, drawableId = 15, textureId = 0 }, -- Undershirts
                        { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
                        { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
                        { componentId = 11, drawableId = 15, textureId = 0 } -- Tops
                    },
                    props = {
                        { propId = 0, drawableId = 3, textureId = 0 }, -- Hats
                        { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
                        { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
                        { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
                        { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
                    }
                }
            }
        }
        