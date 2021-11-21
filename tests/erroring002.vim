" Test substitution repeated in the same line until error. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after CursorHold. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state after CursorHold. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(4)
edit test.txt

if search('long') | execute 'normal! 0' | else | call vimtest#ErrorAndQuit('test line not found') | endif
let g:isErroring = 1
call RunMacroAndCheckMarks(":s/long long/short/\n", 'j', 1)
call vimtap#Is(getpos('.'), [0, 12, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

