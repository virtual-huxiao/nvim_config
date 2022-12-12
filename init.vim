set number		" 显示行号
set relativenumber	" 显示相对行号
set ignorecase		" 搜索时忽略大小写
set smartcase		" 搜索时如果存在大写, 将敏感大小写
set notimeout		" 关闭命令输入的短暂超时
set jumpoptions=stack	" jump list
set wildmode=list:longest   " 设置补全
let mapleader = "\<SPACE>" " 设置leader键
" 取消注释行 o O(命令行模式) 换行(插入模式) 自动补全注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" 解决中文字符显示乱码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
" 共享剪切板
set clipboard^=unnamed,unnamedplus
" --------Tab缩进设置-------
set tabstop=4
set shiftwidth=4
set expandtab " Tab换成空格键位
" 开启高亮光标行
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" 开启高亮光标列
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

" 显示空白空格
set list
set listchars=tab:•\ ,trail:•,extends:»,precedes:«

call plug#begin('~/.config/nvim/plugged')
    " 修改github访问方式, 非用https, 但是需要上传公钥到github
    " let g:plug_url_format = 'git@github.com/%s.git'
    
    " 使用代理的方式, 目前最高效的!!!
    let g:plug_url_format = 'https://ghproxy.com/https://github.com/%s.git'

    Plug 'glepnir/dashboard-nvim' " 添加启动界面

    Plug 'ggandor/leap.nvim'  " 快速移动(s/S触发)
    Plug 'jiangmiao/auto-pairs'

    Plug 'voldikss/vim-floaterm' " 终端浮窗, 回头可以使用toggleterm.nvim替换

    Plug 'simrat39/symbols-outline.nvim', {'branch': 'fix-outline-detection'}  " 文件大纲, 基于LSP(目前存在coc.nvim不兼容问题)

    Plug 'lukas-reineke/indent-blankline.nvim' " 显示缩进线

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

    Plug 'luochen1990/rainbow'  " 彩虹括号

    Plug 'kshenoy/vim-signature' " 显示mark标记

    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive' " 为airline提供git能力
    Plug 'airblade/vim-gitgutter' " 为airline提供文件修改可视得能力

    Plug 'nvim-tree/nvim-tree.lua'  " 树状目录

    " need : 1.nodejs(>=14.x); 2.yarn
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


if !empty(glob("~/.config/nvim/plugged/dashboard-nvim"))
    lua require('dashboard-nvim_')
endif

" -----leap-------
if !empty(glob("~/.config/nvim/plugged/leap.nvim"))
    lua require('leap_')
    autocmd ColorScheme * lua require('leap').init_highlight(true)
endif

syntime on
colorscheme onedark
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ------airline-------------
" 关闭空白符检测
let g:airline#extensions#whitespace#enabled=0

" tabline中buffer显示编号
let g:airline#extensions#tabline#left_alt_sep = ':' "tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1

" 对于z区域, %l是当前行数 %L是当前文件的行数 %p是当前在文件的百分之几
" %v是当前行的第几个字符
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_z = '%l:%L %p%%'

" index-blankline.nvim
if !empty(glob("~/.config/nvim/plugged/indent-blankline.nvim"))
    lua require('index-blankline_')
endif
" telescope
if !empty(glob("~/.config/nvim/plugged/telescope.nvim"))
    lua require('telescope_')
endif
" symbols-outline.nvim
if !empty(glob("~/.config/nvim/plugged/symbols-outline.nvim"))
    lua require('SymbolsOutline_')
endif
" snvim-tree.lua
if !empty(glob("~/.config/nvim/plugged/nvim-tree.lua"))
    lua require('SnvimTree_')
endif
" vim-floaterm
if !empty(glob("~/.config/nvim/plugged/vim-floaterm"))
    let g:floaterm_width  = 0.85
    let g:floaterm_height = 0.85
    let g:floaterm_keymap_new    = '<F7>'   " 打开一个新的终端
    let g:floaterm_keymap_prev   = '<F8>'   " 上一个终端
    let g:floaterm_keymap_next   = '<F9>'   " 下一个终端
    let g:floaterm_keymap_kill   = '<F10>'  " 关闭一个终端
    let g:floaterm_keymap_toggle = '<F12>'  " 切换终端状态(没有的时候新建一个)
endif


" ------jiangmiao/auto-pairs-----
let g:AutoPairsShortcutJump = '<M-n>'  " 设置跳到下一个括号对, Alt+n

" ------luochen1990/rainbow-------
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,\|+\|-_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'css': 0,
\   }
\}

" -------coc extensions--------
" need clangd
let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-json',
            \ 'coc-vimlsp',
            \ 'coc-cmake',
            \ 'coc-highlight'
            \ ]

set signcolumn=number   " 报错再行号处显示

" 对于一些cmake项目, 需要生产相应的数据库, 而coc-clangd默认读build文件下的compile_commands.json
function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('build'))
    execute 'silent !mkdir build'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B build'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()    " 当打开CMake项目的时候, 或者是更新CMake项目, 使用Gcmake, 生产一个json文件给lsp使用, 从而检测项目.
" 如果打开的是makefile工程, 则需要使用rizstto/Bear这个插件, 生产json文件.

" 使用Tab选择建议
set signcolumn=yes
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if !empty(glob("~/.config/nvim/plugged/coc.nvim"))
  " 光标在函数上, 显示文档信息的行为是CocAction('definitionHover')
  imap <silent><expr> <TAB> coc#pum#visible()?coc#pum#confirm():"\<Tab>"  " tab选择建议
  imap <silent><expr> <CR>  coc#pum#visible()?coc#pum#confirm():"\<CR>"   " enter选择建议
  " inoremap <silent><expr> <ESC> coc#pum#visible()?coc#pum#cancel():"\<Esc>"     " 当有提示时esc为关闭提示
  inoremap <silent><expr> <Esc> coc#float#has_float()?"\<Esc>a":"\<Esc>"
  " inoremap <silent><expr> <Esc> coc#float#has_float()?coc#float#close_all(1):"\<Esc>"
  imap <silent><expr> <C-j> coc#pum#visible()?coc#pum#next(0):"\<C-j>"    " ctrl+j向下移动,不选择建议
  imap <silent><expr> <C-k> coc#pum#visible()?coc#pum#prev(0):"\<C-k>"    " ctrl+h向上移动,不选择建议
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
  nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
  nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
  nmap <LEADER>qf <Plug>(coc-fix-current)
  nmap <leader>rn <Plug>(coc-rename)
  xmap <leader>f <Plug>(coc-format-selected)
  command! -nargs=0 Format :call CocAction('format')
endif


" Custom Config
function ShowLineNumIsRelative(relative)
    " set number
    let &relativenumber = a:relative
endfunction
autocmd InsertEnter * nested : call ShowLineNumIsRelative(0) " 进入插入模式显示绝对行号
autocmd InsertLeave * nested : call ShowLineNumIsRelative(1) " 离开插入模式显示相对行号
inoremap <C-j> <Esc><Esc>o| " 下开新行, 两次esc跳出coc.nvim提示
inoremap <C-k> <Esc><Esc>O| " 上开新行, 两次esc跳出coc.nvim提示

  " vim-signature help
  " mx           Toggle mark 'x' and display it in the leftmost column
  " dmx          Remove mark 'x' where x is a-zA-Z

  " m,           Place the next available mark
  " m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
  " m-           Delete all marks from the current line
  " m<Space>     Delete all marks from the current buffer
  " ]`           Jump to next mark
  " [`           Jump to prev mark
  " ]'           Jump to start of next line containing a mark
  " ['           Jump to start of prev line containing a mark
  " `]           Jump by alphabetical order to next mark
  " `[           Jump by alphabetical order to prev mark
  " ']           Jump by alphabetical order to start of next line having a mark
  " '[           Jump by alphabetical order to start of prev line having a mark
  " m/           Open location list and display marks from current buffer

  " m[0-9]       Toggle the corresponding marker !@#$%^&*()
  " m<S-[0-9]>   Remove all markers of the same type
  " ]-           Jump to next line having a marker of the same type
  " [-           Jump to prev line having a marker of the same type
  " ]=           Jump to next line having a marker of any type
  " [=           Jump to prev line having a marker of any type
  " m?           Open location list and display markers from current buffer
  " m<BS>        Remove all markers
