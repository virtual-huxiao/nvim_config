-- require('leap').add_default_mappings()

-- full window search jump
vim.keymap.set({'n','v'}, 's', function () require('leap').leap { target_windows = { vim.fn.win_getid() } } end)

-- all windows jump
vim.keymap.set('n', 'S',
function () require('leap').leap { target_windows = vim.tbl_filter(
  function (win) return vim.api.nvim_win_get_config(win).focusable end,
  vim.api.nvim_tabpage_list_wins(0)
)} end )