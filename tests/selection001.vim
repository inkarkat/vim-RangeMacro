" Test one-char replace over subsequent lines on a linewise selection of 5 lines. 
" Tests that the macro was executed properly only over the selection. 
" Tests that the cursor was positioned on the first column on initial macro
" invocation. 
" Tests cursor end position. 
" Tests that the macro remains intact after the invocation. 

call vimtest#StartTap()
call vimtap#Plan(2)
edit simple.txt

let @m = 'rXj'
normal! 2GV4j
normal \@m
call vimtap#Is(@m, 'rXj', 'Macro intact after invocation')
call vimtap#Is(getpos('.'), [0, 7, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

