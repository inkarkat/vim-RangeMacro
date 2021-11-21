" Test one-char replace over subsequent lines on a range of 5 lines. 
" Tests that the macro was executed properly only over the range. 
" Tests that the macro is still invoked on the very last character of the range. 

edit simple.txt

normal! 4G0
let @m = 'jrX$'
1,5RangeMacro m

call vimtest#SaveOut()
call vimtest#Quit()

