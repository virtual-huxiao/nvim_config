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
