fx_version 'adamant'
game "gta5"

description "Discord Bot For FiveM"
author "Cyber"
client_script 'Client.lua'
server_scripts {
    'Server/Cbot.js', 'Server/Config.lua', 'Server/Server.lua',
    'Server/Commands.lua'
}

server_exports {'RegisterDiscordCommand'}

