" Test one-char replace over subsequent lines on a blockwise selection of 5 lines. 
" Tests that the macro was executed properly only over the selection. 

edit simple.txt

let @m = 'gU2l`[j'
execute "normal! 2G0l\<C-v>2l4j"
normal \@m

call vimtest#SaveOut()
call vimtest#Quit()

