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

-- windows下cmd运行where可以获取到应用的地址
-- linux 下cmd运行which可以获取到应用的地址
