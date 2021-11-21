" Test char substitution until error. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after CursorHold. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state after CursorHold. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(4)
edit simple.txt

normal! 1G0
let g:isErroring = 1
call RunMacroAndCheckMarks('ff~j0', '5j', 1)
call vimtap#Is(getpos('.'), [0, 3, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

