local db = require('dashboard')

db.custom_header = {
"  ██╗   ██╗ █████╗ ██╗  ██╗ █████╗ ███╗   ███╗ ██████╗ ███████╗",
"  ╚██╗ ██╔╝██╔══██╗██║ ██╔╝██╔══██╗████╗ ████║██╔═══██╗╚══███╔╝",
"   ╚████╔╝ ███████║█████╔╝ ███████║██╔████╔██║██║   ██║  ███╔╝ ",
"    ╚██╔╝  ██╔══██║██╔═██╗ ██╔══██║██║╚██╔╝██║██║   ██║ ███╔╝  ",
"     ██║   ██║  ██║██║  ██╗██║  ██║██║ ╚═╝ ██║╚██████╔╝███████╗",
"     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝",
"",
}

db.custom_center = {
  {icon = "", desc = "dashboardRecently lastest session    ", shortcut = "", action = "SessionLoad"},
  {icon = "", desc = "Recently opened files                ", shortcut = "", action = "DashboardFindHistory"},
  {icon = "", desc = "Find File                            ", shortcut = "", action = "Telescope find_files find_command=rg,--hidden,--files"},
  {icon = "", desc = "File Browser                         ", shortcut = "", action = "Telescope file_browser"},
  {icon = "", desc = "Find Word                            ", shortcut = "", action = "Telescope live_grep"},
  {icon = "", desc = "Open Personal dotfiles               ", shortcut = "", action = "edit $MYVIMRC"}
}

db.custom_footer = {"","","Stopping your Mouse!"}
