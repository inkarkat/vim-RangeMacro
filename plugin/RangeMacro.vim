function! RangeMacro#SetRegister( register )
    let s:register = a:register
endfunction
function! RangeMacro#Operator( type )
echomsg '****' string(getpos('.')) string(getpos("'[")) string(getpos("']"))
    if s:register !~# '^[a-z]$' | throw 'ASSERT: s:register not properly set' | endif

    let s:rangeStart = getpos("'[")
    let s:rangeEnd = getpos("']")

    " Append recursive macro invocation if not yet there. 
    execute 'let l:macro = @' . s:register
    " Note: Cannot use "\<Plug>" in comparison; it will never match. 
    "if l:macro !~# s:iterateMapping . '$'
    if strpart(l:macro, strlen(l:macro) - strlen(s:iterateMapping)) !=# s:iterateMapping
	execute 'let @' . s:register . ' .= ' . string(s:iterateMapping)
    endif

    " Start off the iteration by invoking the (augmented) macro once. 
    try
	execute 'normal! @' . s:register
    catch /^Vim\%((\a\+)\)\=:E/
	" v:exception contains what is normally in v:errmsg, but with extra
	" exception source info prepended, which we cut away. 
	let v:errmsg = substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
	echohl ErrorMsg
	echomsg v:errmsg
	echohl None
    endtry
endfunction

function! RangeMacro#Iterate( mode )
    if line('.') < line('$')
	return '@' . s:register
    else
	return ''
    endif
endfunction
let s:iterateMapping = "\<Plug>RangeMacroIterate"
nnoremap <expr> <Plug>RangeMacroIterate RangeMacro#Iterate('n')
inoremap <expr> <Plug>RangeMacroIterate RangeMacro#Iterate('i')

function! s:GenerateMappings()
    for l:register in split('abcdefghijklmnopqrstuvwxyz', '\zs')
	execute printf('nnoremap <silent> %s%s :<C-u>call RangeMacro#SetRegister(%s)<Bar>set opfunc=RangeMacro#Operator<CR>g@', g:RangeMacro_mapping, l:register, string(l:register))
    endfor
endfunction
let g:RangeMacro_mapping = '<Leader>@'
call s:GenerateMappings()
" nnoremap <Plug>RangeMacroOperator :<C-u>set opfunc=RangeMacro#Operator<CR>g@
" if ! hasmapto('<Plug>RangeMacroOperator', 'n')
    " nmap <silent> <Leader>@ <Plug>RangeMacroOperator
" endif
