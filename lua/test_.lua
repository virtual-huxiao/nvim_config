print(os.getenv('systemroot') .. "\n")
local systemroot = os.getenv('systemroot')
if systemroot == nil then
    print("unkonw system!\n")
    return
end

local begin_char = string.sub(systemroot,1,1)
if begin_char == '' then
    print("unknow system!\n")
elseif begin_char == '/' then
    prtin("System is linux or unix-like.\n")
elseif begin_char == 'C' then
    print("System is morden Windows!")
end
