" Test one-char replace over subsequent lines on an inverted range of 5 lines. 
" Tests that the macro was executed from the start of the range, not the cursor
" position. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after the invocation. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit simple.txt

normal! 6G0
call RunMacroAndCheckMarks('rXj', '4k', 1)
call vimtap#Is(getpos('.'), [0, 7, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

