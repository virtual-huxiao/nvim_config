-- keymap
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap



-- Debug
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint(); require'dap_.dap_util_'.store_breakpoints(true)<cr>", opts)
keymap("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opts)
-- keymap("n", "<F2>", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap('n', '<F10>', '<cmd>lua require"dap_.dap_util_".reload_continue()<CR>', opts)
keymap("n", "<Shift><F5>", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "K", "<cmd>lua require'dapui'.eval()<cr>", opts)