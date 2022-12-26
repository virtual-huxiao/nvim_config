-- print(os.getenv('systemroot') .. "\n")
local PlugName = 'dap'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

-- 从命令中获取到lldb_vscode得路径
local systemroot = os.getenv('systemroot')
if systemroot == nil then
    print("unkonw system!\n")
    return
end

local cmd
local lldb_vscode_path
local begin_char = string.sub(systemroot,1,1)
if begin_char == '' then
    print("unknow system!\n")
    return
elseif begin_char == '/' then
    -- prtin("System is linux or unix-like.\n")
    cmd = io.popen('which lldb-vscode')
elseif begin_char == 'C' then
    -- print("System is morden Windows!")
    cmd = io.popen('where.exe lldb-vscode') -- https://www.codenong.com/16775686/ must use where.exe
end

lldb_vscode_path = cmd:read("*all")
if lldb_vscode_path == '' then
    prtin("can't find lldb-vscode in your PATH!\n")
    print('please install llvm, and add your PATH!')
    return
end
-- print(lldb_vscode_path .. '\n')

local dap = require(PlugName)
dap.adapters.lldb = {
    type = 'executable',
    command = lldb_vscode_path,
    name = 'lldb'
}

dap.configurations.cpp = {
    name = 'launch',
    type = 'lldb',
    
}



