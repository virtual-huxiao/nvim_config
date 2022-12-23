local PlugName = 'dashboard'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

local db = require(PlugName)

db.custom_header = {
"  ██╗   ██╗ █████╗ ██╗  ██╗ █████╗ ███╗   ███╗ ██████╗ ███████╗",
"  ╚██╗ ██╔╝██╔══██╗██║ ██╔╝██╔══██╗████╗ ████║██╔═══██╗╚══███╔╝",
"   ╚████╔╝ ███████║█████╔╝ ███████║██╔████╔██║██║   ██║  ███╔╝ ",
"    ╚██╔╝  ██╔══██║██╔═██╗ ██╔══██║██║╚██╔╝██║██║   ██║ ███╔╝  ",
"     ██║   ██║  ██║██║  ██╗██║  ██║██║ ╚═╝ ██║╚██████╔╝███████╗",
"     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝",
}


db.center_pad = 5
db.custom_center = {
  {icon = "", desc = "Open Telescope Fined Files  ", shortcut = "", action = "Telescope find_files"},
  {icon = "", desc = "Open Personal dotfiles      ", shortcut = "", action = "edit $MYVIMRC"},
  {icon = "", desc = "Install Plugs               ", shortcut = "", action = "PlugInstall"},
  {icon = "", desc = "Update  Plugs               ", shortcut = "", action = "PlugUpdate"},
  {icon = "", desc = "Clear   Plugs               ", shortcut = "", action = "PlugClean"},
  
}

db.footer_pad = 5
db.custom_footer = {"You seen, you standing there!"}

-- db.session_directory = "~/.config/nvim/.session"
-- db.session_auto_save_on_exit = true