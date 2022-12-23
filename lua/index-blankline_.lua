local PlugName = 'indent_blankline'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

vim.cmd [[highlight IndentBlanklineContextChar guifg=#EEEE00 gui=nocombine]]
require(PlugName).setup {
    use_treesitter_scope = true,
    show_current_context = true,
    show_end_of_line = true,
    space_char_blankline = " ",
}