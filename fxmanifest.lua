fx_version 'cerulean'
game 'gta5'

description 'A Simple FiveM Script that allows you spawn Both Multi-Player & Single-Player Peds'
lua54 'yes'
version '2.0.0'

shared_scripts {
    'shared/config.lua'
} 

client_scripts {
    'client/client.lua'
}
server_scripts {
    'server/server.lua'
} 


ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/configs/sp.json',
    'html/configs/emotes.json',
    'html/images/*.*'
}

--dependencies {
--    
--}


-- FUTURE DEPENDANCYS
    --'ox_target' -- DO NOT UN COMMENT THIS, THIS IS FOR FUTURE UPDATES THAT ARE NOT CURRENTLY BEING USED.
