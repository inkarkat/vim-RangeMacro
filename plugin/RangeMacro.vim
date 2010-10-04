" RangeMacro.vim: Execute macro repeatedly until the end of a range is reached. 
"
" DEPENDENCIES:
"   - Vim 7.0 or higher. 
"   - RangeMacro.vim autoload script. 
"
" Copyright: (C) 2010 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"	003	03-Oct-2010	Added visual mode mappings. 
"	002	02-Oct-2010	Moved from incubator to proper autoload/plugin
"				scripts. 
"	001	29-Sep-2010	file creation

" Avoid installing twice or when in unsupported Vim version. 
if exists('g:loaded_RangeMacro') || (v:version < 700)
    finish
endif
let g:loaded_RangeMacro = 1

"- configuration --------------------------------------------------------------
if ! exists('g:RangeMacro_mapping')
    let g:RangeMacro_mapping = '<Leader>@'
endif


"- mappings -------------------------------------------------------------------
nnoremap <silent> <expr> <Plug>RangeMacroRecurse RangeMacro#Recurse('n')
inoremap <silent> <expr> <Plug>RangeMacroRecurse RangeMacro#Recurse('i')

function! s:GenerateMappings()
    for l:register in split('abcdefghijklmnopqrstuvwxyz', '\zs')
	execute printf('nnoremap <silent> %s%s :<C-u>call RangeMacro#SetRegister(%s)<Bar>set opfunc=RangeMacro#Operator<CR>g@', g:RangeMacro_mapping, l:register, string(l:register))
	execute printf('xnoremap <silent> %s%s :<C-u>call RangeMacro#Selection(%s)<CR>', g:RangeMacro_mapping, l:register, string(l:register))
    endfor
endfunction
call s:GenerateMappings()
delfunction s:GenerateMappings


"- commands -------------------------------------------------------------------
command! -bar -range -register RangeMacro call RangeMacro#Command(<line1>, <line2>, '<reg>')

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
