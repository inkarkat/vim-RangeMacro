function! RunMacro( macro, motion )
    let @m = a:macro
    execute 'normal \@m' . a:motion
    call vimtap#Is(@m, a:macro, 'Macro intact after invocation')
endfunction

function! RunMacroAndCheckMarks( macro, motion, ... )
    let l:unsetMarks = split((a:0 ? a:1 : 'dfghjk'), '\zs')
    let l:marks = split('abcdefghijklmnopqrstuvwxyz', '\zs')
    call InitMarks(l:marks, l:unsetMarks)
    let l:marksBefore = RecordMarks(l:marks)

	normal! gg0
	call RunMacro(a:macro, a:motion)

    call vimtap#Is(CompareMarks(l:marksBefore, RecordMarks(l:marks)), {}, 'Marks restored to original state')
endfunction

