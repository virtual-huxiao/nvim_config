local PlugName = 'leap'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

-- require('leap').add_default_mappings()

-- full window search jump
-- vim.keymap.set({'n','v'}, 's', function () require('leap').leap { offset = 2, target_windows = { vim.fn.win_getid() } } end)
-- vim.keymap.set({'n','v'}, 'S', function () require('leap').leap { offset = 0, target_windows = { vim.fn.win_getid() } } end)

-- all windows jump
vim.keymap.set({'n','v'}, 's',
function () require('leap').leap { offset = 2,target_windows = vim.tbl_filter(
function (win) return vim.api.nvim_win_get_config(win).focusable end,
  vim.api.nvim_tabpage_list_wins(0)
)} end )
vim.keymap.set({'n','v'}, 'S',
function () require('leap').leap { offset = 0,target_windows = vim.tbl_filter(
function (win) return vim.api.nvim_win_get_config(win).focusable end,
  vim.api.nvim_tabpage_list_wins(0)
)} end )

-- 搜索区域变成灰色
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

vim.api.nvim_create_autocmd(
  {"ColorScheme"},
  {
    pattern = "*",
    callback = function()
      require('leap').init_highlight(true)
    end
  }
)