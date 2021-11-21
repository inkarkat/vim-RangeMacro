" Test a macro that ends in insert mode. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after the invocation. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit simple.txt

normal! 1G0
call RunMacroAndCheckMarks('jI!', '4j', 1)
call vimtap#Is(getpos('.'), [0, 6, 1, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

