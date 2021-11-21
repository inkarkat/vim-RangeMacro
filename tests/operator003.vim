" Test space and replace multiple times over a tag. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after the invocation. 
" Tests cursor end position. 
" Tests that all marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(9)
edit textobjects.txt

execute "normal! gg0/^TAGS:/+2\<CR>ma2j$mbk"
call RunMacroAndCheckMarks("gU$o\<Esc>j0", 'it', 0)
call vimtap#Is(getpos('.'), [0, 16, 1, 0], 'End position 1')
call RunMacroAndCheckMarks('>>j', 'at', 0)
call vimtap#Is(getpos('.'), [0, 17, 1, 0], 'End position 2')
normal! `a
call RunMacroAndCheckMarks('>>j', '`b', 0)
call vimtap#Is(getpos('.'), [0, 15, 1, 0], 'End position 3')

call vimtest#SaveOut()
call vimtest#Quit()

