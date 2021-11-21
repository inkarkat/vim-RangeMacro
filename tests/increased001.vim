" Test macro that increases the number of lines. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after the invocation. 
" Tests cursor end position. 
" Tests that used marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit simple.txt

normal! 2G0
call RunMacroAndCheckMarks('yypVr-j', '4j', 0)
call vimtap#Is(getpos('.'), [0, 12, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

