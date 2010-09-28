" Test a macro that ends in insert mode. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro remains intact after the invocation. 
" Tests that the marks are restored to the original state. 

source helpers/marks.vim
source helpers/runmacro.vim

call vimtest#StartTap()
call vimtap#Plan(2)
edit test.txt

    let s:marks = split('abcdefghijklmnopqrstuvwxyz', '\zs')
    call InitMarks(s:marks, split('dfghjk', '\zs'))
    let s:marksBefore = RecordMarks(s:marks)

	normal! gg0
	call RunMacro('jI!', '3j')

    call vimtap#Is(CompareMarks(s:marksBefore, RecordMarks(s:marks)), {}, 'Marks restored to original state')

call vimtest#SaveOut()
call vimtest#Quit()

