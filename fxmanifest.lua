fx_version "cerulean"
game "gta5"
lua54 "yes"

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
