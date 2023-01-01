local M = {}

M.system = "unknown"
M.separator = '/'

local systemroot = os.getenv('systemroot')
if systemroot == nil then
    M.system = "unknown"
else
    local begin_char = string.sub(systemroot,1,1)
    if begin_char == '' then
        M.system = "unknown"
    elseif begin_char == '/' then
        M.system = '*unix'
        M.separator = '/'
    elseif begin_char == 'C' then
        M.system = 'windows'
        M.separator = '\\'
    end
end

M.trim = function(str)
    return str:gsub("^%s+", ""):gsub("%s+$", "")
end

local function cmd(str) 
    local cmd = io.popen(str)
    local ret = cmd:read('*all')
    ret = ret:gsub("^%s+", ""):gsub("%s+$", "")
    return ret
end

-- where/which 命令, 获取指令位置
M.find = function(arg)
    local ret
    if M.system == 'windows' then
        ret = cmd('where.exe ' .. arg)
    elseif M.system == '*unix' then
        ret = cmd('which ' .. arg)
    end
    return ret
end

M.architecture = "unknown"

local arch = 'unknown'
if M.system == 'windows' then
    arch = os.getenv('PROCESSOR_ARCHITECTURE')
elseif M.system == '*unix' then
    arch = cmd('uname -m')
end
arch = string.upper(arch) -- 为了更好的匹配, 全部大写
if string.find(arch, 'X86_64') or string.find(arch, 'AMD64') then
    M.architecture = 'X86_64'
elseif string.find(arch, 'AARCH64') or string.find(arch, 'ARM64') then
    M.architecture = 'ARM64'
end


return M
