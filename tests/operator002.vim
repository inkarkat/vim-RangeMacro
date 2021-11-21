" Test word-wise replace over a sentence distributed over a range of lines. 
" Tests that the macro wasn't executed on the sentence before the start
" position. 
" Tests that the macro wasn't executed on the sentence after the end
" position. 
" Tests that the macro remains intact after the invocation. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(3)
edit textobjects.txt

execute "normal! gg0/^SENTENCES:/+1\<CR>)"
call RunMacroAndCheckMarks('gUww', ')', 1)
call vimtap#Is(getpos('.'), [0, 5, 8, 0], 'End position')

call vimtest#SaveOut()
call vimtest#Quit()

