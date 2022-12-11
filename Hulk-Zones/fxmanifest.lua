fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
author 'HULK'

dependencies {
	'/server:5848',
	'/onesync',
	'oxmysql',
	'ox_lib',
}

shared_scripts {
	'@ox_lib/init.lua',
	'modules/init.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
}

client_script "client.lua"