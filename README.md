-- IF YOU HAVE DOWNLOADED THE SOURCES INSTED OF THE RELEASE DO NOT EXPECT ALL FETURES TO WORK. THE ARE UPDATED LIVE AND WORK ARE BEING DONE TO THEM CONSTANTLY. THE LIVE UPDATES ARE WHAT GOES INTO THE FULL RELEASES AND WE ARE EXPECTING THE UI FOR v1.3 TO BE DONE WITHIN THE NEXT 2-5 DAYS DEPENDING ON FREETIME AND WORK ABILITY. 

PLEASE ONLY DONLOAD THE RELEASES FOR FULLY WORKING CONTENT

-- Do not remove the credit on any of the provided content. 

-- Bugs and issues break Down

- The ui not working?
    - If you have tried to use the command or keybind required to open the UI You may not be an ADMIN Within the server or have changed the name of the resource. "LNWK-NPCs"

- What is the keybind//command to open the ui?
    - The required keybind is (Capslock by default) and the required Command is (/ui) By defauly

- The /Placeped command is not working?
    - As of version 2.0 We have entirely removed the functionality of /Placeped However the Command Suggestion may still be apearing (Most likely do to a lack of me removing the 2 lines of code related to this)

- Can you add custom NPC's / Peds?
    - Yes, By going into the index.html file and locating the necessary code related to it you can input a custom NPC (You will need to get your own photo of the npc for this to work.)

    - The code for the NPC Is as shown bellow.
```
<div class="modal-options">
                <img src="REPLACE_ME_WITH_IMAGE_URL" alt="Ped Model 2" /> <!--You can use something such as FiveManage to Upload images using a url or upload them to the img folder and use html/images/REPLACE_ME.png -->
                <p>replace_me_with_npc_Spawncode</p>
                <button class="modal-btn" data-option="replace_me_with_npc_name" data-btn="ped-model-btn" data-modal="ped-model-modal">replace_me_with_npc_Spawncode</button>
            </div>
```
- Dose this include all GTA5 Base npcs?
    - Yes this includes all gta5 base & Mp npcs upto gamebuild 3323


- The console is being spammed with please do not edit the resource name
    - This is due to a few simple lines in the client.lua that you can comment out in the client.lua file

    - in line 113-116 comment out the following lines

```
    -- To comment out use (--)
        if GetCurrentResourceName() ~= "LNWK-NPCs" then
            print("Please dont edit the resource name :(")
      end
```

-- Following will containe all of the config and helpfull remarks towards them

                name = "Police NPC", -- This is a name that you can name what ever you want the npc to be labled as so that you dont get mixed up
                
                useMPClothing = false, -- True = Will uses the mpClothing Options Flase = Will use the Modle
                
                model = "s_f_y_ranger_01", -- If UseMPClothing = false this will be the Spawned Ped
                
                coords = vector4(441.39, -978.85, 29.69, 180), -- This is the Peds Location
                
                -- https://forge.plebmasters.de/animations Use Plebmasters to get the animation directory & The animatrion name. 
                
                animationDict = "anim@heists@heist_corona@single_team", -- This is the animation directory
                
                animation = "single_team_loop_boss",  -- This is the animation that would be used both Directory & Animation can be found on plebmasters
                
              --  mpClothing = {
              --      components = {
              --          { componentId = 1, drawableId = 0, textureId = 0 }, -- Masks
              --          { componentId = 3, drawableId = 0, textureId = 0 }, -- Arms
              --          { componentId = 4, drawableId = 1, textureId = 0 }, -- Legs
              --          { componentId = 5, drawableId = 0, textureId = 0 }, -- Bags
              --          { componentId = 6, drawableId = 0, textureId = 0 }, -- Shoes
              --          { componentId = 7, drawableId = 0, textureId = 0 }, -- Accessories
              --          { componentId = 8, drawableId = 15, textureId = 0 }, -- Undershirts
              --          { componentId = 9, drawableId = 0, textureId = 0 }, -- Body Armor
              --          { componentId = 10, drawableId = 0, textureId = 0 }, -- Decals
              --          { componentId = 11, drawableId = 15, textureId = 0 } -- Tops
              --      },
              --      props = {
              --          { propId = 0, drawableId = 3, textureId = 0 }, -- Hats
              --          { propId = 1, drawableId = 0, textureId = 0 }, -- Glasses
              --          { propId = 2, drawableId = 0, textureId = 0 }, -- Ears
              --          { propId = 6, drawableId = 0, textureId = 0 }, -- Watches
              --          { propId = 7, drawableId = 0, textureId = 0 } -- Bracelets
              --          -- drawableId = 15 = The number of clothing relevant to the clothing
              --          -- textureId = 0  = The texture that you want to use on the clothing

