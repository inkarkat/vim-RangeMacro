" Test one-char replace over 5 lines. 

call vimtest#StartTap()
call vimtap#Plan(1)
edit test.txt
normal! gg0

let s:macro = 'rXj'
let @m = s:macro
normal \@m4j
call vimtap#Is(@m, s:macro, 'Macro intact after invocation')

call vimtest#SaveOut()
call vimtest#Quit()

