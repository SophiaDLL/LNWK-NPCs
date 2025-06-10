# DO NOT DOWNLOAD THE SOURCE, THIS IS ALWAYS GOING TO BE UNSTABLE AND MORE THAN LIKELY WILL NOT FUNCTION!

-- Do not remove the credit on any of the provided content. 

-- Following will containe all of the config and helpfull remarks towards them

                name = "Police NPC", -- This is a name that you can name what ever you want the npc to be labled as so that you dont get mixed up
                
                useMPClothing = false, -- True = Will uses the mpClothing Options Flase = Will use the Modle
                
                model = "s_f_y_ranger_01", -- If UseMPClothing = false this will be the Spawned Ped
                
                coords = vector4(441.39, -978.85, 29.69, 180), -- This is the Peds Location
                
                -- https://forge.plebmasters.de/animations Use Plebmasters to get the animation directory & The animatrion name. 
                
                animationDict = "anim@heists@heist_corona@single_team", -- This is the animation directory
                
                animation = "single_team_loop_boss",  -- This is the animation that would be used both Directory & Animation can be found on plebmasters
                
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

                        -- drawableId = 15 = The number of clothing relevant to the clothing
                        -- textureId = 0  = The texture that you want to use on the clothing

-- CORRECT USE OF THE /PlacePed Command

command = /PlacePed
name = "the name of youre ped"
type = "true/false" true = mp Clothing false = Ped Mpdle
gender = "male/Female"
