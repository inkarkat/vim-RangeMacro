" Test availability of mappings for all registers. 

edit simple.txt

call vimtest#StartTap()
let s:registers = '0123456789abcdefghijklmnopqrstuvwxyz".*+'
call vimtap#Plan(strlen(s:registers) + 1)
call vimtap#Is(g:RangeMacro_Registers, s:registers, 'Tested registers agree with supported registers')

for s:register in split(s:registers, '\zs')
    if s:register ==# '.'
	" Cannot set register . directly. 
	normal! Gor.j
    else
	execute printf('let @%s = "r" . %s . "j"', s:register, string(s:register))
    endif
    normal! 2G0
    execute 'normal \@' . s:register . '4j'
    call vimtap#Is(getline(2)[0], s:register, 'Macro in register ' . s:register)
endfor

call vimtest#Quit()

