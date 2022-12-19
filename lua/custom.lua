-- 因为不同得终端对特殊字符_[];等都是不同得字符, 所以无法使用字符确定快捷键 -- 

-- ctrl+l js大括号风格
vim.api.nvim_set_keymap("i", "<C-l>", "<End>{}<Left><CR><Esc>O", {})

-- ;; 行尾分号
vim.api.nvim_set_keymap('i', ";;", "<End>;<CR>", {noremap = true, })
