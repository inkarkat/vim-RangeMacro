" Test one-char replace over subsequent lines on a blockwise selection of 5 lines. 
" Tests that the macro was executed properly only over the selection. 
" Tests that moving the cursor after the block end column stops recursion. 

edit simple.txt
5move 2
5move 3

let @m = 'jbgUee'
execute "normal! 1G02l\<C-v>e5j"
normal \@m

call vimtest#SaveOut()
call vimtest#Quit()

