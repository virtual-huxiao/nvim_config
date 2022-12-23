local PlugName = 'nvim-autopairs'
local status = pcall(require, PlugName)
if (not status) then
  print("can't found Plug: <", PlugName, ">;")
  print("Please use ':PlugInstall' to install plug.")
  return
end

require(PlugName).setup{
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'"}, -- now is not supperted <> , must be costom it --
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'Search',
      highlight_grey='Comment'
    },
}
