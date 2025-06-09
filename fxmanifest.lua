fx_version 'cerulean'
game 'gta5'

author 'laurelnwk.com/team'
description 'A Simple FiveM Script that allows you spawn Both Multi-Player & Single-Player Peds'
lua54 'yes'
version '1.2.0'



-- client_script 'client.lua'
client_scripts {
   -- 'test_write.lua',
    'client.lua'
}
server_scripts {
    'server.lua'
} 
shared_scripts {
    'config.lua'
} 

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

--dependencies {
--    
--}


-- FUTURE DEPENDANCYS
    --'ox_target' -- DO NOT UN COMMENT THIS, THIS IS FOR FUTURE UPDATES THAT ARE NOT CURRENTLY BEING USED.
