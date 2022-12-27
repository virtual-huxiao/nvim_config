-- 从命令中获取到lldb_vscode得路径
local systemroot = os.getenv('systemroot')
if systemroot == nil then
    print("unkonw system!\n")
    return
end

local system
local cmd
local lldb_vscode_path
local separator
local begin_char = string.sub(systemroot,1,1)
if begin_char == '' then
    print("unknow system!\n")
    return
elseif begin_char == '/' then
    -- prtin("System is linux or unix-like.\n")
    cmd = io.popen('which lldb-vscode')
    lldb_vscode_path = cmd:read("*all")
    separator = '/'
    system = '*unix'
elseif begin_char == 'C' then
    -- print("System is morden Windows!")
    cmd = io.popen('where.exe lldb-vscode') -- https://www.codenong.com/16775686/ must use where.exe
    lldb_vscode_path = cmd:read("*all")
    lldb_vscode_path = string.gsub(lldb_vscode_path, '\\', '\\\\')
    separator = '\\'
    system = 'windows'
end

if lldb_vscode_path == '' then
    print("can't find lldb-vscode in your PATH!\n")
    print('please install llvm, and add your PATH!')
    return
end
-- print(lldb_vscode_path .. '\n')

-- config cpp debug 
local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = lldb_vscode_path,
    name = 'lldb'
}

dap.configurations.cpp = {
  -- launch exe
    {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        program = function()
          local ret = vim.fn.input('Path to executable: ', vim.fn.getcwd()  .. separator, 'file')
          if system == 'windows' then
              ret = string.gsub(ret,'/','\\')
              ret = string.gsub(ret, '\\', '\\\\')
          end
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
        setupCommands = {
          {
            description = 'enable pretty printing',
            text = '-enable-pretty-printing',
            ignoreFailures = false
          },
        },
    },
}

dap.configurations.c = dap.configurations.cpp


