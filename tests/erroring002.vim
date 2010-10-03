" Test substitution repeated in the same line until error. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after CursorHold. 
" Tests that all marks are restored to the original state after CursorHold. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit test.txt

if search('long') | execute 'normal! 0' | else | call vimtest#Error('test line not found') | call vimtest#Quit() | endif
let g:isErroring = 1
call RunMacroAndCheckMarks(":s/long long/short/\n", 'j', 1)

call vimtest#SaveOut()
call vimtest#Quit()

