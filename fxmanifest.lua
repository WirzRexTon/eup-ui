fx_version 'adamant'
games { 'gta5' }



local uniformFile = 'outfits.json'

file(uniformFile)
uniform_file(uniformFile)


client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/**/*.lua",
 }
 
client_script "eup_ui.lua"