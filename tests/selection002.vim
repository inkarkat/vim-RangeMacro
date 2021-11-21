" Test one-char replace over subsequent lines on a characterwise selection of 5 lines. 
" Tests that the macro was executed properly only over the selection. 

edit simple.txt

let @m = 'gUl '
normal! 2G0Wv4jfy
normal \@m

call vimtest#SaveOut()
call vimtest#Quit()

