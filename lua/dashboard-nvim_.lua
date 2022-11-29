local db = require('dashboard')

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
  {icon = "", desc = "dashboardRecently lastest session    ", shortcut = "", action = "SessionLoad"},
  {icon = "", desc = "Recently opened files                ", shortcut = "", action = "DashboardFindHistory"},
  {icon = "", desc = "Open Personal dotfiles               ", shortcut = "", action = "edit $MYVIMRC"}
}

db.footer_pad = 5
db.custom_footer = {"Stopping your Mouse!", "Using your Keyboard!"}

-- db.session_directory = "~/.config/nvim/.session"
-- db.session_auto_save_on_exit = true