" Test one-char replace over subsequent lines on a range of 5 lines. 
" Tests that the macro was executed properly only over the range. 
" Tests that the cursor was positioned on the first column on initial macro
" invocation. 
" Tests cursor end position. 
" Tests that the macro remains intact after the invocation. 

call vimtest#StartTap()
call vimtap#Plan(2)
edit simple.txt

normal! G$
let @m = 'rXj'
2,6RangeMacro m
call vimtap#Is(@m, 'rXj', 'Macro intact after invocation')
call vimtap#Is(getpos('.'), [0, 7, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

