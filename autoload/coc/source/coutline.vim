" triggerOnly是什么类型? 传什么值?
" 为什么输入全部, 前几个可以识别到, 后面的就不行?
function! coc#source#coutline#init() abort
	return {
	\ 'priority': 1,
	\ 'firstMatch': 'coutline'
	\ 'filetypes': ['cpp','cxx','cc','h','hpp','vim'],
	\ 'shortcut': 'coutline',
	\ 'triggerCharacters': ['coutline']
	\}
endfunction

function! coc#source#coutline#complete(option, cb) abort
	let items = ['::std::cout<<  <<::std::endl;']
	call a:cb(items)
endfunction