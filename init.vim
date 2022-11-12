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
set expandtab
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

    Plug 'jiangmiao/auto-pairs'

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
let g:airline_section_z = '%l of %L %p%%'

"------NERDTree------------
nnoremap <leader>e :NERDTreeToggle<CR> " Leader+e 呼出

" ------jiangmiao/auto-pairs-----
let g:AutoPairsShortcutJump = '<M-n>'  " 设置跳到下一个括号对, Alt+n

" ------luochen1990/rainbow-------
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
