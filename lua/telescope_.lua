local status, actions = pcall(require, "telescope.actions")
if (not status) then
  return
end

--local actions = require('telescope.actions')
-- Global remapping
------------------------------
require("telescope").setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["o"] = actions.file_edit
      }
    },
    file_ignore_patterns = {"./node_modules"}
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}


--按键设置
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fgf', builtin.git_files, {}) -- 通过git ls-files搜索, 也即项目中的内容
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- 依赖于ripgrep:https://github.com/chinanf-boy/ripgrep-zh
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
