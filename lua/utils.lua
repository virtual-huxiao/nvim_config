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

-- where/which 命令, 获取指令位置
M.find = function(arg)
    local ret
    local cmd
    if self.system == 'windows' then
        cmd = io.popen('where.exe ' .. arg)
    elseif self.system == '*unix' then
        cmd = io.popen('which ' .. arg)
    end
    ret = cmd:read('*all')
    ret = ret:gsub("^%s+", ""):gsub("%s+$", "")
    return ret
end

return M
