local status = pcall(require, "nvim-autopairs")
if (not status) then
    print("can't load nvim-autopairs")
    return
end

require("nvim-autopairs").setup{
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
