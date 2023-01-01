-- print(os.getenv('systemroot') .. "\n")
local PlugName1 = 'dap'
local PlugName2 = 'dapui'
local PlugName3 = 'nvim-dap-virtual-text'
local status1 , status2, status3 = pcall(require, PlugName1) , pcall(require, PlugName2), pcall(require, PlugName3)
local isEnd = false
if (not status1 ) then
  print("can't found Plug: <", PlugName1, ">;")
  print("Please use ':PlugInstall' to install plug.")
  isEnd = true
end
if (not status2 ) then
  print("can't found Plug: <", PlugName2, ">;")
  print("Please use ':PlugInstall' to install plug.")
  isEnd = true
end
if (not status3 ) then
  print("can't found Plug: <", PlugName3, ">;")
  print("Please use ':PlugInstall' to install plug.")
  isEnd = true
end
if isEnd then
  return
end


require('dap_.dap_config_').setup()
require("nvim-dap-virtual-text").setup()

require('dap').set_log_level('TRACE')

