fx_version 'cerulean'
game 'gta5'

author 'Naka'
description 'Reputation System for ESX'
version '1.0'

client_scripts {
    '@mysql-async/lib/MySQL.lua',
    'client.lua'   
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}
