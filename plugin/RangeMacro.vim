" TODO: Capture original range and number of iterations to show "3 macro
" iterations, 3 new lines"
function! RangeMacro#SetRegister( register )
    let s:register = a:register
endfunction
function! s:GetRangeMarks()
    return [ "'" . keys(s:marksRecord)[0], "'" . keys(s:marksRecord)[1]]
endfunction
function! RangeMacro#Operator( type )
echomsg '****' string(getpos('.')) string(getpos("'[")) string(getpos("']"))
    if s:register !~# '^[a-z]$' | throw 'ASSERT: s:register not properly set' | endif

    " The macro may change the number of lines in the range. Thus, we use two
    " marks instead of simply storing the positions of the range edges. Because
    " Vim adapts the mark positions when lines are inserted / removed, the macro
    " will operate on the original range, as intended. 
    let s:marksRecord = ingomarks#ReserveMarks(2)
    let [l:startMark, l:endMark] = s:GetRangeMarks()
    call setpos(l:startMark, getpos("'["))
    call setpos(l:endMark, getpos("']"))
    
    " Append recursive macro invocation if not yet there. 
    execute 'let l:macro = @' . s:register
    " Note: Cannot use "\<Plug>" in comparison; it will never match. 
    "if l:macro !~# s:recurseMapping . '$'
    if strpart(l:macro, strlen(l:macro) - strlen(s:recurseMapping)) !=# s:recurseMapping
	execute 'let @' . s:register . ' .= ' . string(s:recurseMapping)
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

function! RangeMacro#Recurse( mode )
    " TODO: Check whether position or line contents at last position have changed versus last run? 
    "let [l:startMark, l:endMark] = s:GetRangeMarks()
    let [l:startPos, l:endPos] = map(s:GetRangeMarks(), 'getpos(v:val)')
    let [l:startLine, l:startCol] = [l:startPos[1], l:startPos[2]]
    let [l:endLine, l:endCol] = [l:endPos[1], l:endPos[2]]
    if
    \	l:startPos == [0, 0, 0, 0] ||
    \	l:endPos == [0, 0, 0, 0] ||
    \   line('.') < l:startLine ||
    \	(line('.') == l:startLine && col('.') < l:startCol) ||
    \   line('.') > l:endLine ||
    \	(line('.') == l:endLine && col('.') > l:endCol)
	" Went outside of range. 

	" Clean up the recursive invocation appended to the macro. 
	execute 'let l:macro = @' . s:register
	if strpart(l:macro, strlen(l:macro) - strlen(s:recurseMapping)) ==# s:recurseMapping
	    execute 'let  @' . s:register . ' = strpart(l:macro, 0, strlen(l:macro) - strlen(s:recurseMapping))'
	endif

	" Stop recursion. 
	return ''
    else
	" Still inside the range. Recurse. 
	return '@' . s:register
    endif
endfunction
let s:recurseMapping = "\<Plug>RangeMacroRecurse"
nnoremap <expr> <Plug>RangeMacroRecurse RangeMacro#Recurse('n')
inoremap <expr> <Plug>RangeMacroRecurse RangeMacro#Recurse('i')

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
