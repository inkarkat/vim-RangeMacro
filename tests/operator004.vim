" Test one-char replace over subsequent lines on a range of 5 lines. 
" Tests that the macro was executed properly only over the range. 
" Tests cursor end position. 
" Tests that the macro is still invoked on the very last character of the range. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit simple.txt

normal! 1G0
call RunMacroAndCheckMarks('jrX$', '/put/e' . "\<CR>", 1)
call vimtap#Is(getpos('.'), [0, 6, 12, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

