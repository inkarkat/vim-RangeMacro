" Test mapping error on unsupported registers. 

edit simple.txt

call vimtest#StartTap()
let s:writableRegisters = '-/'
let s:otherRegisters = ':%#'
call vimtap#Plan(strlen(s:writableRegisters) + strlen(s:otherRegisters))

for s:register in split(s:writableRegisters, '\zs')
    execute printf('let @%s = "r" . %s . "j"', s:register, string(s:register))
    normal! 2G0
    execute 'normal \@' . s:register . '4j'
    call vimtap#Is(getline(2)[0], ':', 'Macro in register ' . s:register . ' not executed')
endfor
for s:register in split(s:otherRegisters, '\zs')
    normal! 2G0
    let s:changedtick = b:changedtick
    execute 'normal \@' . s:register . '4j'
    call vimtap#Is(b:changedtick, s:changedtick, 'Macro in register ' . s:register . ' not executed')
endfor

call vimtest#Quit()

