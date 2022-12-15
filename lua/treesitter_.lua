for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  config.install_info.url = config.install_info.url:gsub( "https://github.com/","https://ghproxy.com/https://github.com/")
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "lua", "python", "json", "ninja", "llvm",
    "html", "make", "regex", "yaml", "vim"
  },
  auto_install = true,
  sync_install = false,

  -- 启用增量选择(enter增加, base删除)
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    },
  },

  highlight = {
    enable = ture,
    disable = {}
  },
  indent = {
    enabel = false,
    disable = {}
  },
}

-- 开启 Folding(目前和Telescope冲突)
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.wo.foldlevel = 99