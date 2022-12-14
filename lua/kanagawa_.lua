local PlugName = 'kanagawa'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

-- Default options:
require(PlugName).setup({
  undercurl = true,           -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true},
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true},
  specialReturn = true,       -- special highlight for the return keyword
  specialException = true,    -- special highlight for exception handling keywords
  transparent = false,        -- do not set background color
  dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
  globalStatus = false,       -- adjust window separators highlight for laststatus=3
  terminalColors = true,      -- define vim.g.terminal_color_{0,17}
  colors = {
    sumiInk1 = "#242424"
  },
  overrides = {},
  theme = "default"           -- Load "default" theme or the experimental "light" theme
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
