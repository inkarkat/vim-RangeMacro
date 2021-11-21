" Test one-char replace over subsequent lines on a range of 5 lines. 
" Tests that the macro was executed properly only over the range. 
" Tests that the cursor was positioned on the first column on initial macro
" invocation, even with 'nostartofline'. 

edit simple.txt

set nostartofline
normal! G$
let @m = 'rXj'
2,6RangeMacro m

call vimtest#SaveOut()
call vimtest#Quit()

