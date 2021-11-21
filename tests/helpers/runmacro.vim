" Set this to indicate that the macro will end with an error and does not reach
" the end of the range. 
let g:isErroring = 0

function! RunMacro( macro, motion )
    let @m = a:macro
    execute 'normal \@m' . a:motion
    if exists('g:isErroring') && g:isErroring
	call vimtap#Isnt(@m, a:macro, 'Macro not yet restored after invocation')
	doautocmd CursorHold
	call vimtap#Is(@m, a:macro, 'Macro intact after CursorHold')
    else
	call vimtap#Is(@m, a:macro, 'Macro intact after invocation')
    endif
endfunction

function! RunMacroAndCheckMarks( macro, motion, canCheckAllMarks, ...)
    let l:unsetMarks = split(a:0 ? a:1 : 'df', '\zs')
    let l:marks = (a:canCheckAllMarks ? split('abcdefghijklmnopqrstuvwxyz', '\zs') : l:unsetMarks)
    call InitMarks(l:marks, l:unsetMarks)
    let l:marksBefore = RecordMarks(l:marks)

	call RunMacro(a:macro, a:motion)

    call vimtap#Is(CompareMarks(l:marksBefore, RecordMarks(l:marks)), {}, 'Marks restored to original state')
endfunction

