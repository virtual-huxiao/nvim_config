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

    Plug 'ggandor/leap.nvim'  " 快速移动(s/S触发)
    Plug 'jiangmiao/auto-pairs'

    Plug 'Yggdroot/indentLine'  " 缩进线显示(这个插件只能显示空格的缩进Tab不支持)

    Plug 'luochen1990/rainbow'  " 彩虹括号

    Plug 'kshenoy/vim-signature' " 显示mark标记

    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive' " 为airline提供git能力
    Plug 'airblade/vim-gitgutter' " 为airline提供文件修改可视得能力

    Plug 'preservim/nerdtree'

    " file finder(暂时禁用, 没有python扩展支持)
    " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

    " need : 1.nodejs(>=14.x); 2.yarn
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" -----leap-------
lua require('leap').add_default_mappings()

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

"------NERDTree------------
nnoremap <leader>e :NERDTreeToggle<CR> " Leader+e 呼出

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

" ------Yggdroot/LeaderF--------
" let g:Lf_WindowPosition='right'
" let g:Lf_PreviewInPopup=1
" let g:Lf_CommandMap = {
" \   '<C-p>': ['<C-k>'],
" \   '<C-k>': ['<C-p>'],
" \   '<C-j>': ['<C-n>']
" \}
" nmap <leader>f :Leaderf file<CR>        " 查找文件
" nmap <leader>b :Leaderf! buffer<CR>     " 切换已经开打的文件
" nmap <leader>F :Leaderf rg<CR>          " 按内容查找
" let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"

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
  imap <silent><expr> <TAB> coc#pum#visible()?coc#pum#confirm():"\<Tab>"  " tab选择建议
  imap <silent><expr> <ESC> coc#pum#visible()?coc#pum#stop():"\<Esc>"     " 当有提示时esc为关闭提示
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

"  Yggdroot/indentLine 
let g:markdown_syntax_conceal=0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Custom Config
function ShowLineNumIsRelative(relative)
    " set number
    let &relativenumber = a:relative
endfunction
autocmd InsertEnter * nested : call ShowLineNumIsRelative(0) " 进入插入模式显示绝对行号
autocmd InsertLeave * nested : call ShowLineNumIsRelative(1) " 离开插入模式显示相对行号

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
