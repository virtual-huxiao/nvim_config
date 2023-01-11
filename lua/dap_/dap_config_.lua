local M = {}

local function setup_sign()
      local dap_breakpoint = {
	    error = {
	      text = "O",
	      texthl = "LspDiagnosticsSignError",
	      linehl = "",
	      numhl = "",
	    },
	    rejected = {
	      text = "x",
	      texthl = "LspDiagnosticsSignHint",
	      linehl = "",
	      numhl = "",
	    },
	    stopped = {
	      text = ">",
	      texthl = "LspDiagnosticsSignInformation",
	      linehl = "DiagnosticUnderlineInfo",
	      numhl = "LspDiagnosticsSignInformation",
	    },
	  }
	
	  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

    --ui setup
    local dapui = require'dapui'
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            'scopes',
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            -- 'stacks',
            'breakpoints',
            'watches',
          },
          size = 40,
          position = 'right',
        },
        {
          elements = {
            'console',
          },
          size = 5,
          position = 'top',
        },
        {
          elements = {
            'repl',
          },
          size = 12,
          position = 'bottom',
        },
      },
      -- sidebar = {
      --   -- You can change the order of elements in the sidebar
      --   elements = {
      --     -- Provide as ID strings or tables with "id" and "size" keys
      --     {
      --       id = "scopes",
      --       size = 0.35, -- Can be float or integer > 1
      --     },
      --     { id = "stacks", size = 0.35 },
      --     { id = "watches", size = 0.15 },
      --     { id = "breakpoints", size = 0.15 },
      --   },
      --   size = 40,
      --   position = "left", -- Can be "left", "right", "top", "bottom"
      -- },
      -- tray = {
      --   elements = { "repl" },
      --   size = 5,
      --   position = "bottom", -- Can be "left", "right", "top", "bottom"
      -- },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
    })
end

local function setup_ui()
    local dap, dapui = require "dap", require "dapui"
	
	  local debug_open = function()
	    dapui.open()
	    vim.api.nvim_command("DapVirtualTextEnable")
	    vim.api.nvim_command("NvimTreeClose")
	  end
	  local debug_close = function()
	    dap.repl.close()
	    dapui.close()
	    vim.api.nvim_command("DapVirtualTextDisable")
	    -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
	  end
	
	  dap.listeners.after.event_initialized["dapui_config"] = function()
	    debug_open()
	  end
	  dap.listeners.before.event_terminated["dapui_config"] = function()
	    debug_close()
	  end
      dap.listeners.after.event_breakpoint["dapui_config"]  = function()
          debug_open()
      end
	  dap.listeners.before.event_exited["dapui_config"]     = function()
	    debug_close()
	  end
	  dap.listeners.before.disconnect["dapui_config"]       = function()
	    debug_close()
	  end
end
local function load_languages_config()
    require('dap_.dap_cpp_config_')
end

function M.setup()
    setup_sign()
    setup_ui()
    load_languages_config()
end

return M
