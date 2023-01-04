-- config cpp debug 
local dap = require('dap')
local utils = require('utils')
dap.adapters.lldb = {
    type = 'executable',
    command = utils.find('lldb-vscode'), -- lldb在Windows下只支持MinGW工具链;https://github.com/mfussenegger/nvim-dap/issues/307; 如果希望使用Win调试, 则应该使用codelldb的客户端和服务端的配对形式
    name = 'lldb',
    options = {
      -- initialize_timeout_sec = 10
    }
}

local function get_codelldb_path()
    local ret
    if utils.system == 'windows' and utils.architecture == 'X86_64' then
        ret = os.getenv('USERPROFILE')
        ret = ret .. '\\AppData\\Local\\nvim\\cpp_debug_tools\\codelldb-x86_64-windows\\extension\\adapter\\codelldb.exe'
    elseif utils.system == '*unix' and utils.architecture == 'X86_64' then
        ret = '~/.config/nvim/codelldb-x86_64-linux/extension/adapter/codelldb'
    elseif utils.system == '*unix' and utils.architecture == 'ARM64' then
        ret = '~/.config/nvim/codelldb-aarch64-linux/extension/adapter/codelldb'
    end
    return ret
end

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = get_codelldb_path(),
        args = {"--port", "${port}"},

        detached = false,
    }
}

dap.configurations.cpp = {
  -- launch exe
    {
        name = "Launch file(not suppered msvc)",
        type = "lldb",
        request = "launch",
        program = function()
          local ret = vim.fn.input('Path to executable: ', vim.fn.getcwd()  .. utils.separator, 'file')
          return ret
        end,
        args = function()
          local input = vim.fn.input("Input args: ")
          return require('dap_.dap_util_').str2argtable(input)
        end,
        cwd = '${workspaceFolder}',
        env = function()
          local variables = {}
          for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, string.format("%s=%s", k, v))
          end
          return variables
        end,
        stopOnEntry = true,
        runInTerminal = false,
        setupCommands = {
          {
            description = 'enable pretty printing',
            text = '-enable-pretty-printing',
            ignoreFailures = false
          },
        },
    },
    --codelldb
    {
        name = 'Lanch file with codelldb',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local ret = vim.fn.input('Path to executable: ', vim.fn.getcwd()  .. utils.separator, 'file')
          return ret
        end,
        args = function()
        local input = vim.fn.input("Input args: ")
            return require('dap_.dap_util_').str2argtable(input)
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
}

dap.configurations.c = dap.configurations.cpp


