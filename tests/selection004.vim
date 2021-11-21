" Test one-char replace over subsequent lines on a blockwise selection of 5 lines. 
" Tests that the macro was executed properly only over the selection. 
" Tests that moving the cursor before the block start column stops recursion. 

edit simple.txt
execute "normal! 3Go\<Esc>"

let @m = 'gU2l`[j'
execute "normal! 2G0l\<C-v>2l5j"
normal \@m

call vimtest#SaveOut()
call vimtest#Quit()

