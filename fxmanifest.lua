fx_version 'cerulean'
game 'gta5'

author 'Naka'
description 'Reputation System for ESX'
version '1.0.1'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@es_extended/locale.lua',
    'client.lua'   
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

exports {
    'AddReputation',
    'RemoveReputation',
	'ResetReputation',
	'GetReputation'
}