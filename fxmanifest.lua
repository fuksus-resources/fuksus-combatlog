fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Fuksus <https://resources.fuksus.com/>'
description 'Fuksus combatlog'
version '0.0.1'

client_scripts {
    'imports.lua',
    'client/bridge/*.lua',
    'client/main.lua'
}

shared_scripts {
    'shared/*.lua',
    'locale.lua',
    'locales/*.lua'
}

server_scripts {
    'imports.lua',
    'server/bridge/*.lua',
    'server/main.lua'
}

files {
    'client/modules/*.lua',
    'server/modules/*.lua'
}

dependencies {
    '/server:6116',
    '/onesync',
    'ox_lib'
}
